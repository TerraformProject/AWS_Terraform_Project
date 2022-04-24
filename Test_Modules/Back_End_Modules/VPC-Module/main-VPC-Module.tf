locals {

  secondary_ipv4_cidr_blocks = flatten([ for vpc_group, vpc_settings in var.vpc_group: 
                                [ for secondary_ipv4_cidr_block in vpc_settings.secondary_ipv4_cidr_blocks: {
                                    secondary_ipv4_cidr_block = vpc_group
                              } ] ] )

  internet_gateways = flatten([ for vpc_group, vpc_settings in var.vpc_group: 
                                [ for internet_gateway_name in vpc_settings.internet_gateway_names: {
                                    vpc_id = vpc_group
                                    internet_gateway_name = internet_gateway_name
                              } ] ] )

  egress_only_internet_gateways = flatten([ for vpc_group, vpc_settings in var.vpc_group: 
                                  [ for egress_only_internet_gateway_name in vpc_settings.egress_only_internet_gateway_names: {
                                      vpc_id = vpc_group
                                      egress_only_internet_gateway_name = egress_only_internet_gateway_name
                                  } ] ] )

  nat_gateway_names = flatten([ for vpc_group, vpc_settings in var.vpc_group: 
                                  [ for nat_gateway_name in vpc_settings.nat_gateway_names: {
                                      nat_gateway_name = element( split(":", nat_gateway_name ) , 0 )
                                      subnet_id = aws_subnet.subnets[element( split(":", nat_gateway_name ) , 1 )].id
                                  } ] ] )

  default_route_table = flatten([ for vpc_group, vpc_settings in var.vpc_group: 
                                  [ for route_tables, route_table_settings in vpc_settings.vpc_route_tables: {
                                      vpc_id = vpc_group
                                      default_route_table_name = vpc_settings.vpc_default_route_table_name
                                      route_table_name = route_table_settings.route_table_name
                                      associated_routes = route_table_settings.associated_routes
                                  } if vpc_settings.vpc_default_route_table_name == route_table_settings.route_table_name ] ] )

  route_tables = flatten([ for vpc_group, vpc_settings in var.vpc_group: 
                            [ for route_tables, route_table_settings in vpc_settings.vpc_route_tables: {
                                vpc_id = vpc_group
                                default_route_table_name = vpc_settings.vpc_default_route_table_name
                                route_table_name = route_table_settings.route_table_name
                                associated_routes = route_table_settings.associated_routes
                            } if vpc_settings.vpc_default_route_table_name != route_table_settings.route_table_name ] ] )

   vpc_subnet = flatten([ for vpc_group, vpc_settings in var.vpc_group: 
                            [ for subnet, subnet_settings in vpc_settings.vpc_subnets: subnet_settings ]
   ])
}


#########
## VPC ##
#########

resource "aws_vpc" "vpc" {
  for_each = var.create_vpc_group == true ? var.vpc_group : {}

  cidr_block                       = each.value.cidr_block
  enable_dns_hostnames             = each.value.enable_dns_hostnames
  enable_dns_support               = each.value.enable_dns_support
  assign_generated_ipv6_cidr_block = each.value.assign_generated_ipv6_cidr_block

  tags = merge(
    {
      "Name" = format("%s", each.value.vpc_name)
    },
  )
}


###############################
## VPC: Secondary CIDR Block ##
###############################

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  for_each = local.secondary_ipv4_cidr_blocks != {} ? { for o in local.secondary_ipv4_cidr_blocks: o.secondary_ipv4_cidr_block => o } : {}

  vpc_id = aws_vpc.vpc[each.value].id
  cidr_block = each.key
}

##########################
## VPC Internet Gateway ##
##########################

resource "aws_internet_gateway" "igw" {
for_each = local.internet_gateways != {} ? { for o in local.internet_gateways: o.internet_gateway_name => o } : {}

  vpc_id = aws_vpc.vpc[each.value.vpc_id].id

  tags = {
    Name = each.key
  }
}

##################################
## Egress Only Internet Gateway ##
##################################

resource "aws_egress_only_internet_gateway" "egress_only_igw" {
for_each = local.egress_only_internet_gateways != {} ? { for o in local.egress_only_internet_gateways: o.egress_only_internet_gateway_name => o } : {}

vpc_id = aws_vpc.vpc[each.value.vpc_id].id

  tags = {
    Name = each.key
  }
}

##################
## NAT Gateways ##
##################

resource "aws_eip" "nat_gateway_eip" {
for_each = { for o in local.nat_gateway_names: o.nat_gateway_name => o }
vpc      = true

tags = {
    Name = join("-", [each.value.nat_gateway_name, "eip"] )
  }
}

resource "aws_nat_gateway" "nat_gateway" {
for_each = { for o in local.nat_gateway_names: o.nat_gateway_name => o }

allocation_id = aws_eip.nat_gateway_eip[each.value.nat_gateway_name].id 
subnet_id     = aws_subnet.subnets[each.value.subnet_id].id

tags = {
    Name = each.value.nat_gateway_name
  }

depends_on = [
    aws_eip.nat_gateway_eip
]
}

#########################
## DEFAULT ROUTE TABLE ##
#########################

resource "aws_default_route_table" "default_route_table" {
for_each = { for o in local.default_route_table: o.default_route_table_name => o}

  default_route_table_id = aws_vpc.vpc[each.value.vpc_id].default_route_table_id

  dynamic "route" {
    for_each = each.value.associated_routes 
    content {
      # One of the following destinations must be provided
      cidr_block      = lookup(route.value, "cidr_block", null)
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
      destination_prefix_list_id = lookup(route.value, "destination_prefix_list_id", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null) != null ? aws_egress_only_internet_gateway.egress_only_igw[route.value.egress_only_gateway_id].id : null
      gateway_id             = lookup(route.value, "gateway_id", null ) != null ? aws_internet_gateway.igw[route.value.gateway_id].id : null
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null ) != null ? aws_nat_gateway.nat_gateway[route.value.nat_gateway_id].id : null
    }
  }

  tags = {
    Name = each.value.default_route_table_name
  }
}

##################
## Route Tables ##
##################
resource "aws_route_table" "route_tables" {
  for_each = { for o in local.route_tables: o.route_table_name => o}

  vpc_id = aws_vpc.vpc[each.value.vpc_id].id

  dynamic "route" {
    for_each = each.value.associated_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = lookup(route.value, "cidr_block", null)
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
      destination_prefix_list_id = lookup(route.value, "destination_prefix_list_id", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null) != null ? aws_egress_only_internet_gateway.egress_only_igw[route.value.egress_only_gateway_id].id : null
      gateway_id             = lookup(route.value, "gateway_id", null ) != null ? aws_internet_gateway.igw[route.value.gateway_id].id : null
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null ) != null ? aws_nat_gateway.nat_gateway[route.value.nat_gateway_id].id : null
    }
  }

  tags = merge(
    {
      "Name" = each.value.route_table_name
    },
  )
}

############
## Subnet ##
############

resource "aws_subnet" "subnets" {
  for_each = { for o in local.vpc_subnet: o.subnet_name => o } 

  vpc_id = aws_vpc.vpc[element(flatten([for vpc, vpc_settings in var.vpc_group: 
                      [ for subnet, subnet_settings in vpc_settings.vpc_subnets: 
                          [ for subnet_keys, subnet_values in vpc_settings.vpc_subnets: vpc if subnet_values.subnet_name == each.value.subnet_name  ] 
                      ] 
                  ]), 0 )].id

  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block
  ipv6_cidr_block = each.value.ipv6_cidr_block == "" ? null : each.value.ipv6_cidr_block
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(
    {
      "Name" = each.value.subnet_name
    },
  )
}

#####################################
## Subnet Route Table Associations ##
#####################################

resource "aws_route_table_association" "route_table_associations" {
for_each = {for o in local.vpc_subnet: o.subnet_name => o}

  subnet_id      = aws_subnet.subnets[each.value.subnet_name].id
  route_table_id = aws_route_table.route_tables[each.value.route_table_name].id
}