###################
## VPC Variables ##
###################

variable "create_vpc" {
    type = bool
    default = false
}

variable "cidr_block" {
    type = string
    default = ""
}

variable "instance_tenancy" {
    type = string
    default = ""
}

variable "enable_dns_hostnames" {
    type = bool
    default = false
}

variable "enable_dns_support" {
    type = bool
    default = false
}

variable "enable_classiclink" {
    type = bool
    default = false
}

variable "enable_classiclink_dns_support" {
    type = bool
    default = false
}

variable "assign_generated_ipv6_cidr_block" {
    type = bool
    default = false
}

variable "vpc_name" {
    type = string
    default = "VPC"
}

variable "vpc_tags" {
    type = map(string)
    default = {}
}

#########################################
## VPC: Secondary CIDR Block Variables ##
#########################################

variable "vpc_id_sub_cidr" {
    type = string
    default = ""
}

variable "sub_cidr_blocks" {
    type = list(string)
    default = []
}

variable "enable_ipv6" {
    type = bool
    default = false
}

################################
## DHCP Options Set Variables ##
################################

variable "enable_dhcp_options" {
    type = bool
    default = false 
}

variable "dhcp_options_domain_name" {
  type = string
  default = ""
}

variable "dhcp_options_domain_name_servers" {
    type = list(string)
    default = []
}

variable "dhcp_options_ntp_servers" {
    type = list(string)
    default = []
}

variable "dhcp_options_netbios_name_servers" {
    type = list(string)
    default = []
}

variable "dhcp_options_netbios_node_type" {
    type = number
    default = 2
}

variable "dhcp_options_set_name" {
    type = string
    default = ""
}

variable "dhcp_options_tags" {
    type = map(string)
    default = {}
}

############################################
## DHCP Options Set Association Variables ##
############################################

variable "vpc_id_dhcp_options" {
    type = string
    default = ""
}

variable "dhcp_options_id" {
    type = string
    default = ""
}