###############################
## Declared Subnet Variables ##
###############################

variable "create_new_vpc_subnets" {
  description = "Whether or not to create this grouping of subnetes"
  type = bool
  default = false
}

variable "vpc_id" {
    description = "The VPC ID where the subnets and ACLs will be created in"
    type = string
    default = null
}

variable "vpc_subnets" {
    description = "Mapping of objects for the subnets to be created and associated with route tables."
    type = map(object({
        subnet_name = string
        cidr_block = string
        availability_zone = string
        customer_owned_ipv4_pool = string
        assign_ipv6_address_on_creation = bool
        ipv6_cidr_block = string
        map_customer_owned_ip_on_launch = bool
        map_public_ip_on_launch = bool
        outpost_arn = string
        route_table_association = string
        use_existing_acl = bool
        get_existing_acl = map(string)
        create_new_acl = bool
        new_acl_name = string
        new_acl_rules = list(string)
        tags = map(string)

    }))
    default = null
}