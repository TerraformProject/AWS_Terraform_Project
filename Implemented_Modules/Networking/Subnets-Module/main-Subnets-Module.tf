############
## Subnet ##
############

resource "aws_subnet" "subnets" {
  for_each = var.subnets 

  vpc_id = each.value.vpc_id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  customer_owned_ipv4_pool = each.value.customer_owned_ipv4_pool
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  ipv6_cidr_block = each.value.ipv6_cidr_block == "" ? null : each.value.ipv6_cidr_block
  map_customer_owned_ip_on_launch = each.value.map_customer_owned_ip_on_launch
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  outpost_arn = each.value.outpost_arn
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
for_each = var.subnets

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.route_tables[each.value.route_table_association].id
}