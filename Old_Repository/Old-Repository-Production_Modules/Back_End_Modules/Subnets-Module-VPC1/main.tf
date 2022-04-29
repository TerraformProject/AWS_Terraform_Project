########################
## Availability Zones ##
########################

data "aws_availability_zones" "available" {
  all_availability_zones = var.include_all_availability_zones == true ? var.include_all_availability_zones : false
  state = var.include_all_availability_zones != true ? var.filter_az_by_state : null

  dynamic "filter"{
    for_each = var.include_all_availability_zones != true ? var.filter_az_by_name_value : {}
    content  {
      name = each.key
      values = each.value
    } 
  } 

  exclude_names = var.include_all_availability_zones != true ? var.excluded_zone_names : []
  exclude_zone_ids = var.include_all_availability_zones != true ? var.excluded_zone_ids : []

}


###################
## Public subnet ##
###################

resource "aws_subnet" "public_subnets" {
  #for_each = [for k in var.internet_gateways: k if length(var.internet_gateways) > 0 ]
  for_each = var.public_subnets 

  vpc_id = element(lookup(var.public_subnets[each.key], "vpc_id", null), 0)

  cidr_block = element(lookup(var.public_subnets[each.key], "cidr_block", [""]), 0)

  availability_zone = element(lookup(var.public_subnets[each.key], "availability_zone", [""]), 0)

  customer_owned_ipv4_pool = element(lookup(var.public_subnets[each.key], "customer_owned_ipv4_pool", [""]), 0)

  assign_ipv6_address_on_creation = tobool(element(lookup(var.public_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0))

  ipv6_cidr_block = tobool(element(lookup(var.public_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0)) == true ? element(lookup(var.public_subnets[each.key], "ipv6_cidr_block", [""]), 0) : null

  map_customer_owned_ip_on_launch = element(lookup(var.public_subnets[each.key], "map_customer_owned_ip_on_launch", [""]), 0) 

  map_public_ip_on_launch = tobool(element(lookup(var.public_subnets[each.key], "map_public_ip_on_launch", ["false"]), 0))

  outpost_arn = element(lookup(var.public_subnets[each.key], "outpost_arn", [""]), 0)

  tags = merge(
    {
      "Name" = element(lookup(var.public_subnets[each.key], "public_subnet_name", [""]), 0)
    },
    element(lookup(var.public_subnets[each.key], "tags", {}), 0 ),
  )
}

#####################
## Private subnets ##
#####################

resource "aws_subnet" "private_subnets" {
  # for_each = [for k in var.internet_gateways: k if length(var.internet_gateways) > 0 ]
  for_each = var.private_subnets 

  vpc_id = element(lookup(var.private_subnets[each.key], "vpc_id", null), 0)

  cidr_block = element(lookup(var.private_subnets[each.key], "cidr_block", [""]), 0)

  availability_zone = element(lookup(var.private_subnets[each.key], "availability_zone", [""]), 0)

  customer_owned_ipv4_pool = element(lookup(var.private_subnets[each.key], "customer_owned_ipv4_pool", [""]), 0)

  assign_ipv6_address_on_creation = tobool(element(lookup(var.private_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0))

  ipv6_cidr_block = tobool(element(lookup(var.private_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0)) == true ? element(lookup(var.public_subnets[each.key], "ipv6_cidr_block", [""]), 0) : null

  map_customer_owned_ip_on_launch = element(lookup(var.private_subnets[each.key], "map_customer_owned_ip_on_launch", [""]), 0) 

  map_public_ip_on_launch = tobool(element(lookup(var.private_subnets[each.key], "map_public_ip_on_launch", ["false"]), 0))

  outpost_arn = element(lookup(var.private_subnets[each.key], "outpost_arn", [""]), 0)

  tags = merge(
    {
      "Name" = element(lookup(var.private_subnets[each.key], "private_subnet_name", [""]), 0)
    },
    element(lookup(var.private_subnets[each.key], "tags", {}), 0 ),
  )

  
}

######################
## Database subnets ##
######################

resource "aws_subnet" "database_subnets" {
  # for_each = [for k in var.internet_gateways: k if length(var.internet_gateways) > 0 ]
  for_each = var.database_subnets 

  vpc_id = element(lookup(var.database_subnets[each.key], "vpc_id", null), 0)

  cidr_block = element(lookup(var.database_subnets[each.key], "cidr_block", [""]), 0)

  availability_zone = element(lookup(var.database_subnets[each.key], "availability_zone", [""]), 0)

  customer_owned_ipv4_pool = element(lookup(var.database_subnets[each.key], "customer_owned_ipv4_pool", [""]), 0)

  assign_ipv6_address_on_creation = tobool(element(lookup(var.database_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0))

  ipv6_cidr_block = tobool(element(lookup(var.database_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0)) == true ? element(lookup(var.public_subnets[each.key], "ipv6_cidr_block", [""]), 0) : null

  map_customer_owned_ip_on_launch = element(lookup(var.database_subnets[each.key], "map_customer_owned_ip_on_launch", [""]), 0) 

  map_public_ip_on_launch = tobool(element(lookup(var.database_subnets[each.key], "map_public_ip_on_launch", ["false"]), 0))

  outpost_arn = element(lookup(var.database_subnets[each.key], "outpost_arn", [""]), 0)

  tags = merge(
    {
      "Name" = element(lookup(var.database_subnets[each.key], "database_subnet_name", [""]), 0)
    },
    element(lookup(var.database_subnets[each.key], "tags", {}), 0 ),
  )
}