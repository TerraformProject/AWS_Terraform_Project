###############################
## Declared Subnet Variable ##
###############################

variable "subnets" {
    description = "Mapping of objects for the subnets to be created and associated with route tables."
    type = map(object({
        subnet_name = string
        vpc_id = string
        cidr_block = string
        availability_zone = string
        customer_owned_ipv4_pool = string
        assign_ipv6_address_on_creation = bool
        ipv6_cidr_block = string
        map_customer_owned_ip_on_launch = bool
        map_public_ip_on_launch = bool
        outpost_arn = string
        route_table_association = string
        tags = map(string)

    }))
    default = null
}