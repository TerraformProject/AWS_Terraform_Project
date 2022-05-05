
####################
## Get Subnet IDs ##
####################

data "aws_subnets" "get_subnet_ids" {
for_each = var.acl_group  

  tags = each.value.subnet_tags
}


#################
## Network ACl ##
#################

resource "aws_network_acl" "acl_group" {
for_each = var.acl_group 

  vpc_id = var.vpc_id

  subnet_ids = concat(each.value.subnet_ids, data.aws_subnets.get_subnet_ids[each.key].ids )

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

  depends_on = [
    var.vpc_id
  ]
}