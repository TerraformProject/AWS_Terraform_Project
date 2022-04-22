#########################
## Default route table ##
#########################

resource "aws_default_route_table" "default" {
  count = var.manage_default_route_table ? 1 : 0

  default_route_table_id = var.default_route_table_id
  propagating_vgws       = var.default_route_table_propagating_vgws

  dynamic "route" {
    for_each = var.default_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    { "Name" = var.default_route_table_name },
    var.default_route_table_tags,
  )
}

###################
## Publiс routes ##
###################
resource "aws_route_table" "public" {
  for_each = var.Public_Route_Tables

  vpc_id = lookup(var.Public_Route_Tables[each.key], "vpc_id_for_public_route_table" , null)
  propagating_vgws = lookup(var.Public_Route_Tables[each.key], "propagating_vgws_for_public_route_table", [])

  dynamic "route" {
    for_each = lookup(var.Public_Route_Tables[each.key], "associated_routes", {})
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      "Name" = var.public_route_table_name
    },
    var.public_route_table_tags,
  )
}

####################
## Private routes ##
####################
resource "aws_route_table" "private" {
  for_each = var.Private_Route_Tables

  vpc_id = lookup(var.Private_Route_Tables[each.key], "vpc_id_for_private_route_table" , null)
  propagating_vgws = lookup(var.Private_Route_Tables[each.key], "propagating_vgws_for_private_route_table", [])

  dynamic "route" {
    for_each = lookup(var.Private_Route_Tables[each.key], "associated_routes", {})
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      "Name" = var.private_route_table_name
    },
    var.private_route_table_tags,
  )
}

####################
## Database routes ##
####################
resource "aws_route_table" "database" {
  for_each = var.Database_Route_Tables

  vpc_id = lookup(var.Database_Route_Tables[each.key], "vpc_id_for_database_route_table" , null)
  propagating_vgws = lookup(var.Database_Route_Tables[each.key], "propagating_vgws_for_datbase_route_table", [])

  dynamic "route" {
    for_each = lookup(var.Database_Route_Tables[each.key], "associated_routes", {})
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      "Name" = var.database_route_table_name
    },
    var.database_route_table_tags,
  )
}