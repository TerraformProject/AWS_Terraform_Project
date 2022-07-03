locals {

## Get Existing ACL ID ##

  get_acl_id = flatten([ for subnets, subnet_settings in var.vpc_subnets:  {
                          vpc_id = subnet_settings.get_existing_acl.vpc_id
                          subnet_id = "${subnet_settings.get_existing_acl.vpc_acl_tag_value}-${subnets}"
                          subnet_name = subnets
                          tag_key = subnet_settings.get_existing_acl.vpc_acl_tag_key
                          tag_value = subnet_settings.get_existing_acl.vpc_acl_tag_value
                        } if subnet_settings.use_existing_acl == true && subnet_settings.create_new_acl == false ] )

## Specify values for a new ACL to be associated with a created subnet ##

  new_acl = flatten([ for subnets, subnet_settings in var.vpc_subnets: {
                        subnet_id = aws_subnet.subnets[subnets].id 
                        new_acl_name = subnet_settings.new_acl_name
                        new_acl_rules = subnet_settings.new_acl_rules
                        new_acl_tags = subnet_settings.new_acl_tags
                    } if subnet_settings.create_new_acl == true && subnet_settings.use_existing_acl == false ] )
  
}

############
## Subnet ##
############

resource "aws_subnet" "subnets" {
  for_each = var.vpc_subnets 

  vpc_id = var.vpc_id
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
    each.value.new_subnet_tags,
  )
}

#####################################
## Subnet Route Table Associations ##
#####################################

resource "aws_route_table_association" "route_table_associations" {
for_each = var.vpc_subnets

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = each.value.route_table_association
}

#########################
## GET EXISTING ACL ID ##
#########################

data "aws_network_acls" "get_acl_id" {
for_each = { for o in local.get_acl_id: o.subnet_id => o }

  vpc_id = each.value.vpc_id

  filter {
    name = "tag:${each.value.tag_key}"
    values = toset([each.value.tag_value])
  }

  # tags = {
  #   (each.value.tag_key) = (each.value.tag_value)
  # }

  depends_on = [
  aws_subnet.subnets,
  aws_network_acl.vpc_network_acl
]  

}

######################################
## ATTACHING EXISTING ACL TO SUBNET ##
######################################

resource "aws_network_acl_association" "existing_acl_subnet_association" {
for_each = { for o in local.get_acl_id: o.subnet_id => o }

  network_acl_id = element(data.aws_network_acls.get_acl_id[each.value.subnet_id].ids, 0)
  subnet_id      = aws_subnet.subnets[each.value.subnet_name].id 

  depends_on = [
    data.aws_network_acls.get_acl_id,
    aws_subnet.subnets,
    aws_network_acl.vpc_network_acl

  ]  
}

#################################
## ATTACHING NEW ACL TO SUBNET ##
#################################

resource "aws_network_acl_association" "new_acl_subnet_association" {
for_each = { for o in local.new_acl: o.new_acl_name => o }

  network_acl_id = aws_network_acl.vpc_network_acl[each.value.new_acl_name].id 
  subnet_id      = each.value.subnet_id

  # depends_on = [
  #   aws_network_acl.vpc_network_acl,
  #   aws_subnet.subnets
  # ]  
}

#########################
## VPC New Network ACL ##
#########################

resource "aws_network_acl" "vpc_network_acl" {
for_each = { for o in local.new_acl: o.new_acl_name => o }

  vpc_id = var.vpc_id

  dynamic "ingress" {
  for_each = toset( [ for o in each.value.new_acl_rules: o if element( split("|", o ) , 0 ) == "Ingress"  ] )
    content {
        action     = element( split("|", ingress.value) , 1 )
        protocol = element( split("|", ingress.value) , 4 )
        cidr_block = element( split("|", ingress.value) , 2 ) == "IPv4" ? element( split("|", ingress.value) , 3 ) : null
        ipv6_cidr_block = element( split("|", ingress.value) , 2 ) == "IPv6" ? element( split("|", ingress.value) , 3 ) : null
        from_port  = element( split("|", ingress.value) , 5 )
        to_port    = element( split("|", ingress.value) , 6 )
        rule_no    = element( split("|", ingress.value) , 7 )
      } 
  }

  dynamic "egress" {
  for_each = toset( [ for o in each.value.new_acl_rules: o if element( split("|", o ) , 0 ) == "Egress"  ] )
    content {
        action     = element( split("|", egress.value) , 1 )
        protocol = element( split("|", egress.value) , 4 )
        cidr_block = element( split("|", egress.value) , 2 ) == "IPv4" ? element( split("|", egress.value) , 3 ) : null
        ipv6_cidr_block = element( split("|", egress.value) , 2 ) == "IPv6" ? element( split("|", egress.value) , 3 ) : null
        from_port  = element( split("|", egress.value.value) , 5 )
        to_port    = element( split("|", egress.value.value) , 6 )
        rule_no    = element( split("|", egress.value.value) , 7 )
      } 
  }

  tags = merge(
    {
      "Name" = each.value.new_acl_name
    },
    each.value.new_acl_tags
  )
}

