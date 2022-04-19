#########################
## New Security Groups ##
#########################

resource "aws_security_group" "new_security_groups" {
for_each = var.create_new_security_groups == true ? var.new_security_groups : {}

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
    description      = ingress.value.description == "" ? null : ingress.value.description
    from_port        = ingress.value.from_port  
    to_port          = ingress.value.to_port
    protocol         = ingress.value.protocol
    cidr_blocks      = ingress.value.cidr_blocks == [] ? null : ingress.value.cidr_blocks
    ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks == [] ? null : ingress.value.ipv6_cidr_blocks
    self = ingress.value.self
    }
  }

  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
    description      = egress.value.description == "" ? null : egress.value.description
    from_port        = egress.value.from_port  
    to_port          = egress.value.to_port
    protocol         = egress.value.protocol
    cidr_blocks      = egress.value.cidr_blocks == [] ? null : egress.value.cidr_blocks
    ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks == [] ? null : egress.value.ipv6_cidr_blocks
    self = egress.value.self
    }
  }

  tags = each.value.tags
}