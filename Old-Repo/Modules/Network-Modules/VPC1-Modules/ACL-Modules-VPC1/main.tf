###################
## Default NACl ##
###################

resource "aws_default_network_acl" "default_acl" {
  for_each = var.default_network_acl 

  default_network_acl_id = lookup(var.default_network_acl[each.key], "default_network_acl_id", null)

  subnet_ids = lookup(var.public_network_acl[each.key], "default_acl_subnet_ids", null)

 dynamic "ingress" {
    for_each = lookup(var.default_network_acl[each.key], "default_network_acl_ingress", null)
    content {
      action          = lookup(ingress.value, "action", null)
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      from_port       = lookup(ingress.value, "from_port", null)
      icmp_code       = lookup(ingress.value, "icmp_code", null)
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
      protocol        = lookup(ingress.value, "protocol", null)
      rule_no         = lookup(ingress.value, "rule_no", null)
      to_port         = lookup(ingress.value, "to_port", null)
    }
  }
  dynamic "egress" {
    for_each = lookup(var.default_network_acl[each.key], "default_network_acl_egress", null)
    content {
      action          = lookup(egress.value, "action", null)
      cidr_block      = lookup(egress.value, "cidr_block", null)
      from_port       = lookup(egress.value, "from_port", null)
      icmp_code       = lookup(egress.value, "icmp_code", null)
      icmp_type       = lookup(egress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
      protocol        = lookup(egress.value, "protocol", null)
      rule_no         = lookup(egress.value, "rule_no", null)
      to_port         = lookup(egress.value, "to_port", null)
    }
  }

  tags = merge(
    {
      "Name" = format("%s", lookup(var.default_network_acl[each.key], "default_network_acl_name", null))
    },
    lookup(var.default_network_acl[each.key], "default_network_acl_tags", null),
  )
}

#################
## Public NACl ##
#################

resource "aws_network_acl" "public_acl" {
  for_each = var.public_network_acl 

  vpc_id = lookup(var.public_network_acl[each.key], "vpc_id_public_acls", null)
  
  subnet_ids = lookup(var.public_network_acl[each.key], "public_acl_subnet_ids", null)

 dynamic "ingress" {
    for_each = lookup(var.public_network_acl[each.key], "public_network_acl_ingress", null)
    content {
      action          = lookup(ingress.value, "action", null)
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      from_port       = lookup(ingress.value, "from_port", null)
      icmp_code       = lookup(ingress.value, "icmp_code", null)
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
      protocol        = lookup(ingress.value, "protocol", null)
      rule_no         = lookup(ingress.value, "rule_no", null)
      to_port         = lookup(ingress.value, "to_port", null)
    }
  }
  dynamic "egress" {
    for_each = lookup(var.public_network_acl[each.key], "public_network_acl_egress", null)
    content {
      action          = lookup(egress.value, "action", null)
      cidr_block      = lookup(egress.value, "cidr_block", null)
      from_port       = lookup(egress.value, "from_port", null)
      icmp_code       = lookup(egress.value, "icmp_code", null)
      icmp_type       = lookup(egress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
      protocol        = lookup(egress.value, "protocol", null)
      rule_no         = lookup(egress.value, "rule_no", null)
      to_port         = lookup(egress.value, "to_port", null)
    }
  }

  tags = merge(
    {
      "Name" = format("%s", lookup(var.public_network_acl[each.key], "public_network_acl_name", null))
    },
    lookup(var.public_network_acl[each.key], "public_network_acl_tags", null),
  )
}

##################
## Private NACl ##
##################

resource "aws_network_acl" "private_acl" {
  for_each = var.private_network_acl 

  vpc_id = lookup(var.private_network_acl[each.key], "vpc_id_private_acls", null)
  
  subnet_ids = lookup(var.private_network_acl[each.key], "private_acl_subnet_ids", null)

 dynamic "ingress" {
    for_each = lookup(var.private_network_acl[each.key], "private_network_acl_ingress", null)
    content {
      action          = lookup(ingress.value, "action", null)
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      from_port       = lookup(ingress.value, "from_port", null)
      icmp_code       = lookup(ingress.value, "icmp_code", null)
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
      protocol        = lookup(ingress.value, "protocol", null)
      rule_no         = lookup(ingress.value, "rule_no", null)
      to_port         = lookup(ingress.value, "to_port", null)
    }
  }
  dynamic "egress" {
    for_each = lookup(var.private_network_acl[each.key], "private_network_acl_egress", null)
    content {
      action          = lookup(egress.value, "action", null)
      cidr_block      = lookup(egress.value, "cidr_block", null)
      from_port       = lookup(egress.value, "from_port", null)
      icmp_code       = lookup(egress.value, "icmp_code", null)
      icmp_type       = lookup(egress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
      protocol        = lookup(egress.value, "protocol", null)
      rule_no         = lookup(egress.value, "rule_no", null)
      to_port         = lookup(egress.value, "to_port", null)
    }
  }

  tags = merge(
    {
      "Name" = format("%s", lookup(var.private_network_acl[each.key], "private_network_acl_name", null))
    },
    lookup(var.private_network_acl[each.key], "private_network_acl_tags", null),
  )
}

###################
## Database NACl ##
###################

resource "aws_network_acl" "database_acl" {
  for_each = var.database_network_acl 

  vpc_id = lookup(var.database_network_acl[each.key], "vpc_id_database_acls", null)
  
  subnet_ids = lookup(var.database_network_acl[each.key], "database_acl_subnet_ids", null)

 dynamic "ingress" {
    for_each = lookup(var.database_network_acl[each.key], "database_network_acl_ingress", null)
    content {
      action          = lookup(ingress.value, "action", null)
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      from_port       = lookup(ingress.value, "from_port", null)
      icmp_code       = lookup(ingress.value, "icmp_code", null)
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
      protocol        = lookup(ingress.value, "protocol", null)
      rule_no         = lookup(ingress.value, "rule_no", null)
      to_port         = lookup(ingress.value, "to_port", null)
    }
  }
  dynamic "egress" {
    for_each = lookup(var.database_network_acl[each.key], "database_network_acl_egress", null)
    content {
      action          = lookup(egress.value, "action", null)
      cidr_block      = lookup(egress.value, "cidr_block", null)
      from_port       = lookup(egress.value, "from_port", null)
      icmp_code       = lookup(egress.value, "icmp_code", null)
      icmp_type       = lookup(egress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
      protocol        = lookup(egress.value, "protocol", null)
      rule_no         = lookup(egress.value, "rule_no", null)
      to_port         = lookup(egress.value, "to_port", null)
    }
  }

  tags = merge(
    {
      "Name" = format("%s", lookup(var.database_network_acl[each.key], "database_network_acl_name", null))
    },
    lookup(var.database_network_acl[each.key], "database_network_acl_tags", null),
  )
}