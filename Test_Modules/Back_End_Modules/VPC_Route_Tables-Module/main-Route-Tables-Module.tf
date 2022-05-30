locals {
  
## Egress Only Gateway ## 

    new_target_egress_gateway = flatten([ for route_tables, tables in var.route_tables: [
                                              for routes, route_values in tables.associated_routes: [
                                                for target_values, values in route_values.target: lookup(route_values.target.target_values, "egress_only_gateway_name", "") if route_values.target.new_target == true && route_values.target.type == "egress_only_gateway"      
                                          ] ] ] )

## Internet Gateway ##

    new_target_internet_gateway = flatten([ for route_tables, tables in var.route_tables: [
                                              for routes, route_values in tables.associated_routes: [
                                                for target_values, values in route_values.target: lookup(route_values.target.target_values, "internet_gateway_name", "") if route_values.target.new_target == true && route_values.target.type == "internet_gateway"      
                                          ] ] ] ) 

## NAT Gateway ##

    new_target_nat_gateway = flatten([ for route_tables, tables in var.route_tables: [
                                          for routes, route_values in tables.associated_routes: route_values.target.target_values if route_values.target.type == "nat_gateway" && route_values.target.new_target == true      
                                          ] ] )

    new_target_nat_gateway_eip = flatten([ for route_tables, tables in var.route_tables: [
                                              for routes, route_values in tables.associated_routes: [
                                                for target_values, values in route_values.target: lookup(route_values.target.target_values, "nat_gateway_name", "") if route_values.target.new_target == true && route_values.target.type == "nat_gateway"      
                                          ] ] ] )

## VPC Endpoint ##

    new_target_vpc_endpoint = flatten([ for route_tables, tables in var.route_tables: [
                                          for routes, route_values in tables.associated_routes: {
                                            route_table_key = route_tables
                                            vpc_endpoint_name = lookup(route_values.target.target_values, "vpc_endpoint_name", "" )
                                            vpc_endpoint_type = lookup(route_values.target.target_values, "vpc_endpoint_type", "" )
                                            service_name = lookup(route_values.target.target_values, "service_name", "" )
                                            auto_accept = lookup(route_values.target.target_values, "auto_accept", false )
                                            route_table_ids = lookup(route_values.target.target_values, "route_table_ids" , "" )
                                            subnet_ids = lookup(route_values.target.target_values, "subnet_ids", "" )
                                            private_dns_enabled = lookup(route_values.target.target_values, "private_dns_enabled", false )
                                            policy = lookup(route_values.target.target_values, "policy", "" )
                                            security_group_ids = lookup(route_values.target.target_values, "security_group_ids", "" )
                                          } if route_values.target.type == "vpc_endpoint" && route_values.target.new_target == true      
                                          ] ] )

## Network Interface ##

    new_target_network_interface = flatten([ for route_tables, tables in var.route_tables: [
                                          for routes, route_values in tables.associated_routes: {
                                            network_interface_name = lookup(route_values.target.target_values, "network_interface_name", "" )
                                            description = lookup(route_values.target.target_values, "description", "" )
                                            interface_type = lookup(route_values.target.target_values, "interface_type", "" )
                                            source_dest_check = lookup(route_values.target.target_values, "source_dest_check", false )
                                            subnet_id       = lookup(route_values.target.target_values, "subnet_id", "" )
                                            ipv4_prefix_count = lookup(route_values.target.target_values, "ipv4_prefix_count", 0 )
                                            ipv4_prefixes = lookup(route_values.target.target_values, "ipv4_prefixes", "" )
                                            private_ip_list_enabled = lookup(route_values.target.target_values, "private_ip_list_enabled", false )
                                            private_ip_list = lookup(route_values.target.target_values, "private_ip_list", "" )
                                            private_ips = lookup(route_values.target.target_values, "private_ips", "" )
                                            private_ips_count = lookup(route_values.target.target_values, "private_ips_count", 0 )
                                            ipv6_address_list_enabled = lookup(route_values.target.target_values, "ipv6_address_list_enabled", false )
                                            ipv6_prefixes = lookup(route_values.target.target_values, "ipv6_prefixes", "" )
                                            ipv6_address_list = lookup(route_values.target.target_values, "ipv6_address_list", "" )
                                            ipv6_addresses = lookup(route_values.target.target_values, "ipv6_addresses", "" )
                                            ipv6_prefix_count = lookup(route_values.target.target_values, "ipv6_prefix_count", 0 )
                                            security_groups = lookup(route_values.target.target_values, "security_groups", "" )
                                            instance_id = lookup(route_values.target.target_values, "instance_id", "" )
                                            device_index = lookup(route_values.target.target_values, "device_index", null )
                                          } if route_values.target.type == "network_interface" && route_values.target.new_target == true      
                                          ] ] )

## Transit Gateway ##

    new_target_transit_gateway = flatten([ for route_tables, tables in var.route_tables: [
                                          for routes, route_values in tables.associated_routes: {
                                            tgw_attachment_name = lookup(route_values.target.target_values, "tgw_attachment_name", "" )
                                            tgw_id = lookup(route_values.target.target_values, "tgw_id", "" )
                                            tgw_default_route_table_association = lookup(route_values.target.target_values, "tgw_default_route_table_association", false )
                                            tgw_default_route_table_propogation = lookup(route_values.target.target_values, "tgw_default_route_table_propogation", false )
                                            tgw_route_table_id = lookup(route_values.target.target_values, "tgw_route_table_id", "" )
                                            subnet_ids = lookup(route_values.target.target_values, "subnet_ids", "" )
                                            appliance_mode_support = lookup(route_values.target.target_values, "appliance_mode_support", "disable" )
                                            dns_support = lookup(route_values.target.target_values, "dns_support", "disable" )
                                            ipv6_support = lookup(route_values.target.target_values, "ipv6_support", "disable" )
                                          } if route_values.target.type == "transit_gateway" && route_values.target.new_target == true      
                                          ] ] )

## Local Gateway Route ##

    new_target_local_gateway = flatten([ for route_tables, tables in var.route_tables: [
                                          for routes, route_values in tables.associated_routes: {
                                            new_local_gateway_route_table_vpc_association = lookup(route_values.target.target_values, "new_local_gateway_route_table_vpc_association", false )
                                            local_gateway_route_table_id = lookup(route_values.target.target_values, "local_gateway_route_table_id", "" )
                                            new_local_gateway_route = lookup(route_values.target.target_values, "new_local_gateway_route", false )
                                            local_gateway_destination_cidr_block = lookup(route_values.target.target_values, "local_gateway_destination_cidr_block", "" )
                                            local_gateway_virtual_interface_group_id = lookup(route_values.target.target_values, "local_gateway_virtual_interface_group_id", "" )
                                          } if route_values.target.type == "local_gateway" && route_values.target.new_target == true      
                                          ] ] )

## VPC Peering Connection ##

    new_target_vpc_peering_connection = flatten([ for route_tables, tables in var.route_tables: [
                                          for routes, route_values in tables.associated_routes: {
                                            vpc_peering_connection_name = lookup(route_values.target.target_values, "vpc_peering_connection_name", "" )
                                            peer_owner_id = lookup(route_values.target.target_values, "peer_owner_id", "" )
                                            peer_vpc_id = lookup(route_values.target.target_values, "peer_vpc_id", "" )
                                            peer_region = lookup(route_values.target.target_values, "peer_region", "" )
                                            auto_accept = lookup(route_values.target.target_values, "auto_accept", false )
                                            allow_remote_vpc_dns_resolution = lookup(route_values.target.target_values, "allow_remote_vpc_dns_resolution", "" )
                                            allow_classic_link_to_remote_vpc = lookup(route_values.target.target_values, "allow_classic_link_to_remote_vpc", "" )
                                            allow_vpc_to_remote_classic_link = lookup(route_values.target.target_values, "allow_vpc_to_remote_classic_link", "" )
                                          } if route_values.target.type == "vpc_peering_connection" && route_values.target.new_target == true      
                                          ] ] )

## Carrier Gateway ##

    new_target_carrier_gateway = flatten([ for route_tables, tables in var.route_tables: [
                                          for routes, route_values in tables.associated_routes: {
                                            carrier_gateway_name = lookup(route_values.target.target_values, "carrier_gateway_name", "" )
                                          } if route_values.target.type == "carrier_gateway" && route_values.target.new_target == true      
                                          ] ] )                                        

}


##################
## Route Tables ##
##################
resource "aws_route_table" "route_tables" {
  for_each = var.create_route_tables == true ? var.route_tables : {}

  vpc_id = var.vpc_id
  propagating_vgws = each.value.propagating_vgws

  dynamic "route" {
    for_each = each.value.associated_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = lookup(route.value.destination, "ipv4_cidr_block", null)
      ipv6_cidr_block = lookup(route.value.destination, "ipv6_cidr_block", null)
      destination_prefix_list_id = lookup(route.value.destination, "destination_prefix_list_id", null)

      # One of the following targets must be provided
      egress_only_gateway_id = route.value.target.new_target == false && route.value.target.type == "egress_only_gateway" ? route.value.target.target_values.egress_only_gateway_id : route.value.target.new_target == true && route.value.target.type == "egress_only_gateway" ? aws_egress_only_internet_gateway.new_target_egress_only_gateway[route.value.target.target_values.egress_only_gateway_name].id : null
      carrier_gateway_id = lookup(route.value.target.target_values, "carrier_gateway_name", null ) != null ? aws_ec2_carrier_gateway.new_target_carrier_gateway[route.value.target.target_values.carrier_gateway_name].id : null
      core_network_arn =  route.value.target.type == "core_network" ? route.value.target.target_values.core_network_arn : null  
      local_gateway_id = route.value.target.new_target == false && route.value.target.type == "local_gateway" ? route.value.target.target_values.local_gateway_id : route.value.target.new_target == true && route.value.target.type == "local_gateway" ? data.aws_ec2_local_gateway_route_table.get_local_route_table["${route.value.target.target_values.local_gateway_route_table_id}-${route.value.target.target_values.local_gateway_destination_cidr_block}"].local_gateway_id : null 
      gateway_id             = route.value.target.new_target == false && route.value.target.type == "internet_gateway" ? route.value.target.target_values.internet_gateway_id : route.value.target.new_target == true && route.value.target.type == "internet_gateway" ? aws_internet_gateway.new_target_internet_gateway[route.value.target.target_values.internet_gateway_name].id : null
      nat_gateway_id         = route.value.target.new_target == false && route.value.target.type == "nat_gateway" ? route.value.target.target_values.nat_gateway_id : route.value.target.new_target == true && route.value.target.type == "nat_gateway" ? aws_nat_gateway.new_target_nat_gateway[route.value.target.target_values.nat_gateway_name].id : null
      network_interface_id   = route.value.target.new_target == false && route.value.target.type == "network_interface" ? route.value.target.target_values.network_interface_id : route.value.target.new_target == true && route.value.target.type == "network_interface" ? aws_network_interface.new_target_network_interface[route.value.target.target_values.network_interface_name].id : null
      transit_gateway_id     = route.value.target.new_target == false && route.value.target.type == "transit_gateway" ? route.value.target.target_values.existing_tgw_id : route.value.target.new_target == true && route.value.target.type == "transit_gateway" ? aws_ec2_transit_gateway_vpc_attachment.new_target_tgw_vpc_attachment[route.value.target.target_values.tgw_attachment_name].id : null
      vpc_endpoint_id           = route.value.target.new_target == false && route.value.target.type == "vpc_endpoint" ? route.value.target.target_values.vpc_endpoint_id : route.value.target.new_target == true && route.value.target.type == "vpc_endpoint" ? aws_vpc_endpoint.new_target_vpc_endpoint[route.value.target.target_values.vpc_endpoint_name].id : null
      vpc_peering_connection_id = route.value.target.new_target == false && route.value.target.type == "vpc_peering_connection" ? route.value.target.target_values.vpc_peering_connection_id : route.value.target.new_target == true && route.value.target.type == "vpc_peering_connection" ? aws_vpc_peering_connection.new_target_vpc_peering_connection[route.value.target.target_values.vpc_peering_connection_name].id : null
    }
  }

  tags = merge(
    {
      "Name" = each.value.route_table_name
    },
    each.value.route_table_tags
  )

depends_on = [
  data.aws_ec2_local_gateway_route_table.get_local_route_table
]

}

##############################################
## New Target: Egress-Only Internet Gateway ##
##############################################

resource "aws_egress_only_internet_gateway" "new_target_egress_only_gateway" {
for_each = toset(compact(local.new_target_egress_gateway))
  vpc_id = var.vpc_id

  tags = {
    Name = each.value
  }
}

##################################
## New Target: Internet Gateway ##
##################################

resource "aws_internet_gateway" "new_target_internet_gateway" {
for_each = toset(compact(local.new_target_internet_gateway))
  vpc_id = var.vpc_id

  tags = {
    Name = each.value
  }
}

#############################
## New Target: NAT Gateway ##
#############################

resource "aws_nat_gateway" "new_target_nat_gateway" {
for_each = { for o in local.new_target_nat_gateway: o.nat_gateway_name => o }

  allocation_id = aws_eip.new_target_nat_gateway_eip[each.value.nat_gateway_name].id
  subnet_id     = each.value.subnet_id

  tags = {
    Name = each.value.nat_gateway_name
  }

  depends_on = [aws_eip.new_target_nat_gateway_eip]
}

resource "aws_eip" "new_target_nat_gateway_eip" {
for_each = toset(compact(local.new_target_nat_gateway_eip))

  vpc = true

  tags = {
    Name = "${each.value}-eip"
  }
  
}

##############################
## New Target: VPC Endpoint ##
##############################

resource "aws_vpc_endpoint" "new_target_vpc_endpoint" {
for_each = { for o in local.new_target_vpc_endpoint: o.vpc_endpoint_name => o }

  vpc_id       = var.vpc_id 
  vpc_endpoint_type = each.value.vpc_endpoint_type
  service_name = each.value.service_name
  auto_accept = each.value.auto_accept
  #route_table_ids = each.value.vpc_endpoint_type == "Gateway" ? aws_route_table.route_tables[each.value.route_table_key].id : null
  subnet_ids = [each.value.subnet_ids]
  private_dns_enabled = each.value.private_dns_enabled
  policy = each.value.policy
  security_group_ids = [each.value.security_group_ids]

  tags = {
    Name = each.value.vpc_endpoint_name
  }
}

###################################
## New Target: Network Interface ##
###################################

resource "aws_network_interface" "new_target_network_interface" {
for_each = { for o in local.new_target_network_interface: o.network_interface_name => o }
  description = each.value.description
  interface_type = each.value.interface_type
  source_dest_check = each.value.source_dest_check
  subnet_id       = each.value.subnet_id
  ipv4_prefix_count = each.value.ipv4_prefix_count == 0 ? null : each.value.ipv4_prefix_count
  ipv4_prefixes = [each.value.ipv4_prefixes] == [""] ? null : [each.value.ipv4_prefixes]
  private_ip_list_enabled = each.value.private_ip_list_enabled
  private_ip_list = [each.value.private_ip_list] == [""] ? null : [each.value.private_ip_list]
  private_ips = [each.value.private_ips] == [""] ? null : [each.value.private_ips]
  private_ips_count = each.value.private_ips_count == 0 ? null : each.value.private_ips_count
  ipv6_address_list_enabled = each.value.ipv6_address_list_enabled
  ipv6_prefixes = [each.value.ipv6_prefixes] == [""] ? null : [each.value.ipv6_prefixes]
  ipv6_address_list = [each.value.ipv6_address_list] == [""] ? null : [each.value.ipv6_address_list]
  ipv6_addresses = [each.value.ipv6_addresses] == [""] ? null : [each.value.ipv6_addresses]
  ipv6_prefix_count = each.value.ipv6_prefix_count == 0 ? null : each.value.ipv6_prefix_count
  security_groups = [each.value.security_groups]

  attachment {
    instance     = each.value.instance_id
    device_index = each.value.device_index
  }

  tags = {
    Name = each.value.network_interface_name
  }
}

#################################
## New Target: Transit Gateway ##
#################################

resource "aws_ec2_transit_gateway_vpc_attachment" "new_target_tgw_vpc_attachment" {
for_each = { for o in local.new_target_transit_gateway: o.tgw_attachment_name => o }

  vpc_id = var.vpc_id
  transit_gateway_id = each.value.tgw_id
  transit_gateway_default_route_table_association = each.value.tgw_default_route_table_association
  transit_gateway_default_route_table_propagation = each.value.tgw_default_route_table_propogation
  subnet_ids = split(", ", each.value.subnet_ids)
  appliance_mode_support = each.value.appliance_mode_support
  dns_support = each.value.dns_support
  ipv6_support = each.value.ipv6_support

  tags = {
    Name = each.value.tgw_attachment_name
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "new_target_tgw_route_table_association" {
for_each = { for o in local.new_target_transit_gateway: o.tgw_attachment_name => o if o.tgw_route_table_id != "" }

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.new_target_tgw_vpc_attachment[each.value.tgw_attachment_name].id 
  transit_gateway_route_table_id = each.value.tgw_route_table_id
}

###############################
## New Target: Local Gateway ##
###############################

data "aws_ec2_local_gateway_route_table" "get_local_route_table" {
for_each = { for o in local.new_target_local_gateway: "${o.local_gateway_route_table_id}-${o.local_gateway_destination_cidr_block}" => o }

  local_gateway_route_table_id = each.value.local_gateway_route_table_id
}

resource "aws_ec2_local_gateway_route_table_vpc_association" "new_target_local_gateway_vpc_association" {
for_each = { for o in local.new_target_local_gateway: "${o.local_gateway_route_table_id}-${o.local_gateway_destination_cidr_block}" => o if o.new_local_gateway_route_table_vpc_association == true }

  local_gateway_route_table_id = each.value.local_gateway_route_table_id
  vpc_id                       = var.vpc_id
}

resource "aws_ec2_local_gateway_route" "new_target_local_gateway_route" {
for_each = { for o in local.new_target_local_gateway: "${o.local_gateway_route_table_id}-${o.local_gateway_destination_cidr_block}" => o }

  destination_cidr_block                   = each.value.local_gateway_destination_cidr_block
  local_gateway_route_table_id             = each.value.local_gateway_route_table_id
  local_gateway_virtual_interface_group_id = each.value.local_gateway_virtual_interface_group_id
}

########################################
## New Target: VPC Peering Connection ##
########################################

resource "aws_vpc_peering_connection" "new_target_vpc_peering_connection" {
for_each = { for o in local.new_target_vpc_peering_connection: o.vpc_peering_connection_name => o }

  vpc_id        = var.vpc_id
  peer_owner_id = each.value.peer_owner_id
  peer_vpc_id   = each.value.peer_vpc_id
  peer_region   = each.value.peer_region
  auto_accept = each.value.auto_accept

   dynamic requester  {
  for_each = contains(flatten([split("/", each.value.allow_remote_vpc_dns_resolution)  , split("/", each.value.allow_classic_link_to_remote_vpc), split("/", each.value.allow_vpc_to_remote_classic_link)]), "requester") == true ? { for k in local.new_target_vpc_peering_connection: "${var.vpc_id}-${each.value.peer_vpc_id}-requester-settings" => k } : {}

  content {
        allow_remote_vpc_dns_resolution = contains(split("/", each.value.allow_remote_vpc_dns_resolution), "requester" ) == true ? true : false
        allow_classic_link_to_remote_vpc = contains(split("/", each.value.allow_classic_link_to_remote_vpc), "requester" ) == true ? true : false
        allow_vpc_to_remote_classic_link = contains(split("/", each.value.allow_vpc_to_remote_classic_link), "requester" ) == true ? true : false
    }
  }

  dynamic accepter  { 
  for_each = contains(flatten([split("/", each.value.allow_remote_vpc_dns_resolution)  , split("/", each.value.allow_classic_link_to_remote_vpc), split("/", each.value.allow_vpc_to_remote_classic_link)]), "accepter") == true ? { for k in local.new_target_vpc_peering_connection: "${var.vpc_id}-${each.value.peer_vpc_id}-accepter-settings" => k } : {}

  content {
        allow_remote_vpc_dns_resolution = contains(split("/", each.value.allow_remote_vpc_dns_resolution), "accepter" ) == true ? true : false
        allow_classic_link_to_remote_vpc = contains(split("/", each.value.allow_classic_link_to_remote_vpc), "accepter" ) == true ? true : false
        allow_vpc_to_remote_classic_link = contains(split("/", each.value.allow_vpc_to_remote_classic_link), "accepter" ) == true ? true : false
    }
  
  }

  tags = {
    Name = each.value.vpc_peering_connection_name
  }
}

#################################
## New Target: Carrier Gateway ##
#################################

resource "aws_ec2_carrier_gateway" "new_target_carrier_gateway" {
for_each = { for o in local.new_target_carrier_gateway: o.carrier_gateway_name => o }

  vpc_id = var.vpc_id

  tags = {
    Name = each.value.carrier_gateway_name
  }
}