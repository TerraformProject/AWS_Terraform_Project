locals {
  route_tables = flatten([ for vpc_group, vpc_settings in var.vpc_group: 
                            [ for route_tables, route_table_settings in vpc_settings.vpc_route_tables: route_table_settings]
   ])

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
      "Name" = format("%s", each.valaue.vpc_name)
    },
  )
}


###############################
## VPC: Secondary CIDR Block ##
###############################

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = var.associate_cidr_blocks == true ? length(var.cidr_blocks_associated) : 0

  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_blocks_associated[count.index]
}

##################
## Route Tables ##
##################
resource "aws_route_table" "route_tables" {
  for_each = var.create_vpc_group == true ? var.vpc_group : {}

  vpc_id = aws_vpc.vpc[each.key].id

  dynamic "route" {
    for_each = {for o in local.route_tables: o.route_table_name => o}
    content {
      # One of the following destinations must be provided
      cidr_block      = lookup(route.value, "cidr_block", null)
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
      destination_prefix_list_id = lookup(route.value, "destination_prefix_list_id", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null) != null ? aws_egress_only_internet_gateway.this[lookup(route.value, "egress_only_gateway_id", null)].id : null
      gateway_id             = lookup(route.value, "gateway_id", null ) != null ? aws_internet_gateway.this[lookup(route.value, "gateway_id", null )].id : null
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null ) != null ? aws_nat_gateway.nat_gateway[lookup(route.value, "nat_gateway_id", null )].id : null
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null) != null ? aws_ec2_transit_gateway.transit_gateway[lookup(route.value, "transit_gateway_id", null)].id : null
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null) != null ? aws_ec2_transit_gateway.transit_gateway[lookup(route.value, "vpc_endpoint_id", null)].vpc_endpoint_type : null
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null) != null ? aws_vpc_peering_connection.vpc_peering_connection[lookup(route.value, "vpc_peering_connection_id", null)].id : null
    }
  }

  tags = merge(
    {
      "Name" = each.value.route_table_name
    },
    each.value.tags
  )
}

############
## Subnet ##
############

resource "aws_subnet" "subnets" {
  for_each = { for o in local.vpc_subnet: o.subnet_name => o } 

  vpc_id = element(flatten([for vpc, vpc_settings in var.vpc_group: 
                      [ for subnet, subnet_settings in vpc_settings.vpc_subnets: 
                          [ for subnet_keys, subnet_values in vpc_settings.vpc_subnets.subnet_settings: vpc if subnet_values.subnet_name == each.value.subnet_name  ] 
                      ] 
                  ]), 0 )

  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block
  ipv6_cidr_block = each.value.ipv6_cidr_block == "" ? null : each.value.ipv6_cidr_block
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(
    {
      "Name" = each.value.subnet_name
    },
    each.value.tags,
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