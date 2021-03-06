################
## VPC Variables
################

variable "create_vpc_group" {
  description = "Whether or not to create a VPC grouping"
  type = bool
  default = false
}

variable "vpc_group" {
  description = "Values stored to declare multiple VPCs to form a VPC group"
  type = map(object({
      vpc_name = string
      cidr_block = string
      secondary_ipv4_cidr_blocks = list(string)
      assign_generated_ipv6_cidr_block = bool
      enable_dns_support = bool
      enable_dns_hostnames = bool
      internet_gateway_name = string
      egress_only_internet_gateway_names = list(string)
      nat_gateway_names = list(string)
      vpc_default_route_table_name = string
      vpc_route_tables = map(object({
          route_table_name = string
          route_table_tags = map(string)
          associated_routes = map(map(any))
      }))
      vpc_subnets = map(object({
        subnet_name = string
        availability_zone = string
        cidr_block = string
        ipv6_newbits_netnumb = string
        assign_ipv6_address_on_creation = bool
        map_public_ip_on_launch = string
        route_table_name = string
        subnet_tags = map(string)
      }))
      default_acl = object({
        acl_name = string
        acl_rules = list(string)
      })
      default_security_group = object({
        security_group_name = string
        security_group_rules = list(string)
      })
  }))
}