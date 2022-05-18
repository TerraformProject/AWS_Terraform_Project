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
                                            private_ip_list_enable = lookup(route_values.target.target_values, "private_ip_list_enabled", false )
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
      egress_only_gateway_id = lookup(route.value.target.target_values, "egress_only_gateway_name", null) != null ? aws_egress_only_internet_gateway.new_target_egress_only_gateway[route.value.target.target_values.egress_only_gateway_name].id : null
      # carrier_gateway_id = lookup(route.value.target.target_values, "carrier_gateway_id", null ) != null ? aws_ec2_carrier_gateway.carrier_gateway[lookup(route.value, "carrier_gateway_id", null )].id : null
      # core_network_arn = lookup(route.value.target.target_values, "core_network_arn", null ) != null ? aws_networkmanager_global_network.core_network[lookup(route.value, "core_network_arn", null )].arn : null  
      # local_gateway_id = lookup(route.value.target.target_values, "local_gateway_id", null ) != null ? aws_networkmanager_global_network.core_network[lookup(route.value, "local_gateway_id", null )].arn : null  
      gateway_id             = lookup(route.value.target.target_values, "internet_gateway_name", null) != null ? aws_internet_gateway.new_target_internet_gateway[route.value.target.target_values.internet_gateway_name].id : null
      # instance_id            = lookup(route.value.target.target_values, "instance_id", null)
      nat_gateway_id         = lookup(route.value.target.target_values, "nat_gateway_name", null) != null ? aws_nat_gateway.new_target_nat_gateway[route.value.target.target_values.nat_gateway_name].id : null
      network_interface_id   = lookup(route.value.target.target_values, "network_interface_name", null) != null ? aws_nat_gateway.new_target_nat_gateway[route.value.target.target_values.network_interface_name].id : null
      # transit_gateway_id     = lookup(route.value.target.target_values, "transit_gateway_id", null) != null ? aws_ec2_transit_gateway.transit_gateway[lookup(route.value, "transit_gateway_id", null)].id : null
      # vpc_endpoint_id           = lookup(route.value.target.target_values, "vpc_endpoint_id", null) != null ? aws_ec2_transit_gateway.transit_gateway[lookup(route.value, "vpc_endpoint_id", null)].vpc_endpoint_type : null
      # vpc_peering_connection_id = lookup(route.value.target.target_values, "vpc_peering_connection_id", null) != null ? aws_vpc_peering_connection.vpc_peering_connection[lookup(route.value, "vpc_peering_connection_id", null)].id : null
    }
  }

  tags = merge(
    {
      "Name" = each.value.route_table_name
    },
    each.value.route_table_tags
  )
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
  route_table_ids = [each.value.route_table_ids]
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
for_each = { for o in local.new_target_vpc_endpoint: o.network_interface_name => o }
  description = each.value.description
  interface_type = each.value.interface_type
  source_dest_check = each.value.source_dest_check
  subnet_id       = each.value.subnet_id
  ipv4_prefix_count = each.value.ipv4_prefix_count == 0 ? null : each.value.ipv4_prefix_count
  ipv4_prefixes = [each.value.ipv4_prefixes]
  private_ip_list_enabled = each.value.private_ip_list_enabled
  private_ip_list = [each.value.private_ip_list]
  private_ips = [each.value.private_ips]
  private_ips_count = each.value.private_ips_count == 0 ? null : each.value.private_ips_count
  ipv6_address_list_enabled = each.value.ipv6_address_list_enabled
  ipv6_prefixes = [each.value.ipv6_prefixes]
  ipv6_address_list = [each.value.ipv6_address_list]
  ipv6_addresses = [each.value.ipv6_addresses]
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