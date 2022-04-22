#####################################
## Public Security Group Variables ##
#####################################

variable "public_security_groups" {
  description = "Mapping of objects for specified security groups"
  type = map(object({
    name = string
    description = string
    vpc_id = string
    ingress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      self = bool
    }))
    egress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      self = bool
    }))
    tags = map(string)
  }))
  default = null
}

######################################
## Private Security Group Variables ##
######################################

variable "private_security_groups" {
  description = "Mapping of objects for specified security groups"
  type = map(object({
    name = string
    description = string
    vpc_id = string
    ingress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      self = bool
    }))
    egress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      self = bool
    }))
    tags = map(string)
  }))
  default = null
}

######################################
## Datbase Security Group Variables ##
######################################

variable "database_security_groups" {
  description = "Mapping of objects for specified security groups"
  type = map(object({
    name = string
    description = string
    vpc_id = string
    ingress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      self = bool
    }))
    egress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      self = bool
    }))
    tags = map(string)
  }))
  default = null
}