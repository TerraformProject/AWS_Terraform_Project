

############################
## Network ACl  Variables ##
############################
variable "create_new_acls" {
  description = "Whether or not to create new acls"
  type = bool
  default = false
}

variable "vpc_id" {
  description = "The VPC for the ACLs to be located in"
  type = string
  default = ""
}

variable "acl_group" {
    type = map(object({
        acl_name = string
        acl_subnet_names = list(string)
        acl_subnet_tags = map(string)
        acl_ingress_rules = map(object({
            action = string
            cidr_block = string
            from_port = number
            icmp_code       = number
            icmp_type       = number
            ipv6_cidr_block = string
            protocol = string
            rule_no = number
            to_port = number
        }))
        acl_egress_rules = map(object({
            action = string
            cidr_block = string
            from_port = number
            icmp_code       = number
            icmp_type       = number
            ipv6_cidr_block = string
            protocol = string
            rule_no = number
            to_port = number
        }))
        tags = map(string)
    }))
    default = null
}