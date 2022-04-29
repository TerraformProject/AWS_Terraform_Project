locals {
  
    # get_subnet_ids_name = flatten( { for acl, acl_settings in var.acl_group: acl_settings.acl_subnet_names => acl_settings }  ) 

#     get_subnet_ids_tag = flatten([ for acl, acl_settings in var.vpc_group: 
#                                     [ for subnet_tags in acl_settings.acl_subnet_tags: data.aws_subnet.get_subnet_id_tags[subnet_tags].ids ] 
#                                 ])

 }

####################################
## Get Subnet IDs by Subnet Names ##
####################################
data "aws_subnets" "get_subnet_id_name" {
for_each = var.acl_group
#for_each = { for o in local.get_subnet_ids_name: o.subnet_names => o }

  filter {
    name   = "tag:Name"
    values = each.value.acl_subnet_names
  }
}

###################################
## Get Subnet IDs by Subnet Tags ##
###################################
data "aws_subnets" "get_subnet_id_tags" {
for_each = var.acl_group

  tags = each.value.acl_subnet_tags
}

#################
## Network ACl ##
#################

resource "aws_network_acl" "acl_group" {
for_each = var.acl_group 

  vpc_id = var.vpc_id
  subnet_ids = concat(data.aws_subnets.get_subnet_id_name[each.key].ids, data.aws_subnets.get_subnet_id_tags[each.key].ids)

 dynamic "ingress" {
      for_each = lookup(each.value, "acl_ingress_rules", null)
      content {
        action          = ingress.value.action
        cidr_block      = ingress.value.cidr_block
        from_port       = ingress.value.from_port
        icmp_code       = ingress.value.icmp_code
        icmp_type       = ingress.value.icmp_type
        ipv6_cidr_block = ingress.value.ipv6_cidr_block
        protocol        = ingress.value.protocol
        rule_no         = ingress.value.rule_no
        to_port         = ingress.value.to_port
      }
    }

  dynamic "egress" {
    for_each = lookup(each.value, "acl_egress_rules", null)
    content {
      action            = egress.value.action
        cidr_block      = egress.value.cidr_block
        from_port       = egress.value.from_port
        icmp_code       = egress.value.icmp_code
        icmp_type       = egress.value.icmp_type
        ipv6_cidr_block = egress.value.ipv6_cidr_block
        protocol        = egress.value.protocol
        rule_no         = egress.value.rule_no
        to_port         = egress.value.to_port
    }
  }

  tags = merge(
    {
      "Name" = each.value.acl_name
    },
    each.value.tags,
  )
}