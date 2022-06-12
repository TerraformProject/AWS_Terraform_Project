## Create New Security Groups Variable ##
variable "create_new_security_groups" {
  description = "Whether to create new security groups for the load balancer"
  type = bool
  default = false
}

variable "new_security_groups" {
  description = "Settings for the security groups to add to the load balancer"
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
  default = {}
}