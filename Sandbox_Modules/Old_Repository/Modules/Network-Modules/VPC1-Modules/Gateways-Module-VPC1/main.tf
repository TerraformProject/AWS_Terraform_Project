
######################
## Internet Gateway ##
######################

resource "aws_internet_gateway" "this" {
  # for_each = tomap([ for k in var.internet_gateways: k if length(var.internet_gateways) > 0 ])
  for_each = var.internet_gateways

  vpc_id = element(lookup(var.internet_gateways[each.key], "vpc_id", null), 0)

  tags = merge(
    {
      "Name" = element(lookup(var.internet_gateways[each.key], "igw_name", ""), 0)
    },
     element(lookup(var.internet_gateways[each.key], "igw_tags", null), 0)
    
  )
}

##################################
## Egress Only Internet Gateway ##
##################################

resource "aws_egress_only_internet_gateway" "this" {
  # for_each = [for k in var.internet_gateways: k if length(var.internet_gateways) > 0 ]
  for_each = var.egress_internet_gateways

  vpc_id = element(lookup(var.egress_internet_gateways[each.key], "vpc_id", null), 0)

  tags = merge(
    {
      "Name" = lookup(var.egress_internet_gateways[each.key], "egress_only_igw_name", "")
    },
    element(lookup(var.egress_internet_gateways[each.key], "egress_igw_tags", null), 0)
  )
}

##################
## NAT Gateways ##
##################

resource "aws_nat_gateway" "nat_gateway" {
  # for_each = [for k in var.internet_gateways: k if length(var.internet_gateways) > 0 ]
  for_each = var.nat_gateways 

  allocation_id = element(lookup(var.nat_gateways[each.key], "eip_allocation_id", ""), 0)
  subnet_id     = element(lookup(var.nat_gateways[each.key], "subnet_id", ""), 0) 

  tags = { Name = element(lookup(var.nat_gateways[each.key], "nat_gateway_name", ""), 0)} 
}



