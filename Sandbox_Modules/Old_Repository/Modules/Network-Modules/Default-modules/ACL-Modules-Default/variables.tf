##################################
## VPC1: Default NACl Varaibles ##
##################################

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

variable "public_network_acl" {
    type = map(object({
        public_network_acl_name = string
        vpc_id = string
        public_acl_subnet_ids = list(string)
        public_network_acl_ingress = map(object({
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
        public_network_acl_egress = map(object({
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
## VPC1: Private NACl Variables ##
##################################

variable "private_network_acl" {
    type = map(object({
        private_network_acl_name = string
        vpc_id = string
        private_acl_subnet_ids = list(string)
        private_network_acl_ingress = map(object({
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
        private_network_acl_egress = map(object({
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

###################################
## VPC1: Database NACl Variables ##
###################################

variable "database_network_acl" {
    type = map(object({
        database_network_acl_name = string
        vpc_id = string
        database_acl_subnet_ids = list(string)
        database_network_acl_ingress = map(object({
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
        database_network_acl_egress = map(object({
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