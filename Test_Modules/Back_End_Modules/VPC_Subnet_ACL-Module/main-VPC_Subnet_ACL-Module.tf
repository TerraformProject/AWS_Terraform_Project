locals {

  get_acl_id = flatten([ for subnets, subnet_settings in var.vpc_subnets:  {
                          vpc_id = subnet_settings.get_existing_acl.vpc_id
                          subnet_id = "${subnet_settings.get_existing_acl.vpc_acl_tag_value}-${subnets}"
                          subnet_name = subnets
                          tag_key = subnet_settings.get_existing_acl.vpc_acl_tag_key
                          tag_value = subnet_settings.get_existing_acl.vpc_acl_tag_value
                        } if subnet_settings.use_existing_acl == true && subnet_settings.create_new_acl == false ] )

  # existing_acl = flatten([ for subnets, subnet_settings in var.vpc_subnets: [
  #                           for existing_acl_setting in subnet_settings.get_existing_acl: {
  #                           tag_value = subnet_settings.get_existing_acl.vpc_acl_tag_value
  #                           subnet_id = subnets
  #                       } ] if subnet_settings.use_existing_acl == true && subnet_settings.create_new_acl == false ] )

  new_acl = flatten([ for subnets, subnet_settings in var.vpc_subnets: {
                        subnet_id = aws_subnet.subnets[subnets].id 
                        new_acl_name = subnet_settings.new_acl_name
                    } if subnet_settings.create_new_acl == true && subnet_settings.use_existing_acl == false ] )
  
  new_acl_rules = flatten([ for subnets, subnet_settings in var.vpc_subnets: 
                            [ for acl_rule in subnet_settings.new_acl_rules: {
                                new_acl_name = subnet_settings.new_acl_name
                                direction = element( split("|", acl_rule) , 0 )
                                action = element( split("|", acl_rule) , 1 )
                                ip_type = element( split("|", acl_rule) , 2 )
                                cidr_block = element( split("|", acl_rule) , 3 )
                                protocol   = element( split("|", acl_rule) , 4 )
                                from_port  = element( split("|", acl_rule) , 5 )
                                to_port    = element( split("|", acl_rule) , 6 )
                                rule_no    = element( split("|", acl_rule) , 7 )
                            } if subnet_settings.create_new_acl == true ]
                          ] )
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
    each.value.tags,
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
    name   = join("", ["tag:", each.value.tag_key])
    values = [each.value.tag_value]
  }
}

######################################
## ATTACHING EXISTING ACL TO SUBNET ##
######################################

resource "aws_network_acl_association" "existing_acl_subnet_association" {
for_each = { for o in local.get_acl_id: o.subnet_id => o }

  network_acl_id = element(data.aws_network_acls.get_acl_id[each.value.subnet_id].ids, 0 )
  subnet_id      = aws_subnet.subnets[each.value.subnet_name].id 

depends_on = [
  data.aws_network_acls.get_acl_id,
  aws_subnet.subnets
]  
}




#########################
## VPC New Network ACL ##
#########################

resource "aws_network_acl" "vpc_network_acl" {
for_each = { for o in local.new_acl: o.new_acl_name => o }

  vpc_id = var.vpc_id

  subnet_ids = [each.value.subnet_id]

  dynamic "ingress" {
  for_each = { for o in local.new_acl_rules: "${o.new_acl_name}-${o.rule_no}" => o if o.direction == "Ingress" }
    content {
        action     = ingress.value.action
        protocol = ingress.value.protocol
        cidr_block = ingress.value.ip_type == "IPv4" ? ingress.value.cidr_block : null
        ipv6_cidr_block = ingress.value.ip_type == "IPv6" ? ingress.value.cidr_block : null
        from_port  = ingress.value.from_port
        to_port    = ingress.value.to_port
        rule_no    = ingress.value.rule_no
      } 
  }

  dynamic "egress" {
  for_each = { for o in local.new_acl_rules: "${o.new_acl_name}-${o.rule_no}" => o if o.direction == "Egress" }
    content {
        action     = egress.value.action
        protocol = egress.value.protocol
        cidr_block = egress.value.ip_type == "IPv4" ? egress.value.cidr_block : null
        ipv6_cidr_block = egress.value.ip_type == "IPv6" ? egress.value.cidr_block : null
        from_port  = egress.value.from_port
        to_port    = egress.value.to_port
        rule_no    = egress.value.rule_no
      }
  }

  tags = merge(
    {
      "Name" = each.value.new_acl_name
    },
  )
}

