###################
## Default NACl ##
###################

resource "aws_default_network_acl" "default_acl" {
  for_each = var.default_network_acl 

  default_network_acl_id = each.value.default_network_acl_id
  subnet_ids = each.value.default_acl_subnet_ids

  dynamic "ingress" {
      for_each = lookup(each.value, "default_network_acl_ingress", null)
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
    for_each = lookup(each.value, "default_network_acl_egress", null)
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
      "Name" = each.value.default_network_acl_name
    },
    each.value.tags,
  )
}

#################
## Public NACl ##
#################

resource "aws_network_acl" "public_acls" {
  for_each = var.public_network_acl 

  vpc_id = each.value.vpc_id
  subnet_ids = each.value.public_acl_subnet_ids

 dynamic "ingress" {
      for_each = lookup(each.value, "public_network_acl_ingress", null)
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
    for_each = lookup(each.value, "public_network_acl_egress", null)
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
      "Name" = each.value.public_network_acl_name
    },
    each.value.tags,
  )
}