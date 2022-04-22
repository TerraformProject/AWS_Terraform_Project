##################################
## VPC1: Default NACl Varaibles ##
##################################

variable "create_default_network_acl" {
  description = "Whether or not to create a default network ACL for associated VPC."
  type = bool
  default = false
}

variable "default_network_acl" {
    type = map(object({
        default_network_acl_name = string
        default_network_acl_id = string
        default_acl_subnet_ids = list(string)
        default_network_acl_ingress = map(object({
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
        default_network_acl_egress = map(object({
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

##################################
## VPC1: Public NACl  Variables ##
##################################

variable "acl_group" {
    type = map(object({
        acl_name = string
        vpc_id = string
        acl_subnet_ids = list(string)
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