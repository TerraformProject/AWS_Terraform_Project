###################
## VPC Variables ##
###################

variable "create_vpc" {
    description = "Whether to create a vpc or not"
    type = bool
    default = false
}

variable "cidr_block" {
    description = "CIDR block of the vpc"
    type = string
    default = ""
}

variable "instance_tenancy" {
    description = "instance tenancy of the vpc"
    type = string
    default = ""
}

variable "enable_dns_hostnames" {
    description = "Whether DNS hostnames are enabled or not"
    type = bool
    default = false
}

variable "enable_dns_support" {
    description = "Whether DNS support is enabled or not"
    type = bool
    default = false
}

variable "enable_classiclink" {
    description = "Whether classiclik is enabled or not"
    type = bool
    default = false
}

variable "enable_classiclink_dns_support" {
    description = "Whether DNS classiclink is enabled or not"
    type = bool
    default = false
}

variable "assign_generated_ipv6_cidr_block" {
    description = "Whether or not this vpc should have a generated IPv6 CIDR block added"
    type = bool
    default = false
}

variable "enable_ipv6" {
    type = bool
    default = false
}

variable "vpc_name" {
    description = "Name of the VPC"
    type = string
    default = "VPC"
}

variable "vpc_tags" {
    description = "Tags of the VPC"
    type = map(string)
    default = {}
}

#########################################
## VPC: Secondary CIDR Block Variables ##
#########################################

variable "associate_cidr_blocks" {
    description = "Whether or not to associate the specified cidr blocks with the newly created VPC"
    type = bool
    default = false
}

variable "cidr_blocks_associated" {
    description = "The cidr blocks to associate with the newly created vpc"
    type = list(string)
    default = []
}

################################
## DHCP Options Set Variables ##
################################

variable "enable_dhcp_options" {
    description = "Whether or not to create a dhcp options set for the vpc"
    type = bool
    default = false 
}

variable "dhcp_options_domain_name" {
    description = "Domain name to be used for the DHCP options set"
  type = string
  default = ""
}

variable "dhcp_options_domain_name_servers" {
    description = "Nameservers to be used fpr the dhcp options set"
    type = list(string)
    default = []
}

variable "dhcp_options_ntp_servers" {
    description = "NTP servers to be used for the dhcp option set"
    type = list(string)
    default = []
}

variable "dhcp_options_netbios_name_servers" {
    description = "Netbios name server to be used for the dhcp option set"
    type = list(string)
    default = []
}

variable "dhcp_options_netbios_node_type" {
    description = "Netbios node type"
    type = number
    default = 2
}

variable "dhcp_options_set_name" {
    description = "Name for the dhcp options set"
    type = string
    default = ""
}

variable "dhcp_options_tags" {
    description = "Tags for the dhcp options set"
    type = map(string)
    default = {}
}

######################################
## VPC Peering Connection Variables ##
######################################

variable "vpc_peering_connections" {
    description = "The VPC peering connections to be created and used by routing tables"
    type = map(object({
        peer_owner_id = string
        peer_vpc_id = string
        vpc_id = string
        auto_accept = bool
        peer_region = string
        acceptor = map(bool)
        requester = map(bool)
        tags = map(string)
    }))
}

################################
## Internet Gateway Variables ##
################################

variable "internet_gateways" {
    description = "map of objects for the internet gateways to be added to the vpc"
    type = map(object({
        igw_name = string
        vpc_id = string
        tags = map(string)
    }))
    default = {}
}

############################################
## Egress Only Internet Gateway Variables ##
############################################

variable "egress_internet_gateways" {
    description = "map of objects for the egress only internet gateways for the vpc"
    type = map(object({
        egress_igw_name = string
        vpc_id = string
        tags = map(string)
    }))
    default = {}
}

###########################
## NAT Gateway Variables ##
###########################

variable "nat_gateways" {
    description = "map of objects for the NAT gateways for the vpc"
    type = map(object({
        nat_gateway_name = string
        subnet_id = string
        create_new_eip = bool 
        eip_allocation_id = string
        new_eip_index = number
        tags = map(string)
    }))
    default = {}
}

###########################
## VPC Endpoint Variable ##
###########################

variable "vpc_endpoints" {
    description = "Settings to create vpc endpoints to be used in route tables"
    type = map(object({
        vpc_endpoint_type = string
        service_name = string
        vpc_id = string
        auto_accept = bool
        policy = string
        private_dns_enabled = bool
        route_table_ids = list(string)
        subnet_ids = list(string)
        security_group_ids = list(string)
        tags = map(string)
    }))
}

##############################
## Transit Gateway Variable ##
##############################

variable "transit_gateways" {
    description = "Settings for transit gateways tobe used in route tables"
    type = map(object({
        description = string
        amazon_side_asn = number
        auto_accept_shared_attachments = string
        default_route_table_association = string
        default_route_table_propagation = string
        dns_support = string
        vpn_ecmp_support = string

        tags = map(string)
    }))
}

###################################
## Default Route Table Variables ##
###################################

variable "manage_default_route_table" {
    description = "Whether or not to manage the default route table for the vpc"
    type = bool
    default = false
}

variable "default_route_table_id" {
    description = "The exported default route table id from the created vpc to be used"
    type = string
    default = null
}

variable "default_route_table_propagating_vgws" {
    description = "Propagating VGWs for the default route table"
    type = list(string)
    default = []
}

variable "default_route_table_routes" {
    description = "Routes for the default route table"
    type = map(string)
    default = {}
}

variable "default_route_table_name" {
    description = "Name for the default rout table"
    type = string
    default = ""
}

variable "default_route_table_tags" {
    description = "Tags for the default route table"
    type = map(string)
    default = {}
}

###################################
## Declared Route Table Variable ##
###################################

variable "route_tables" {
    description = "mapping of objects for the route tables to be created and the routes to be associated"
    type = map(object({
        route_table_name = string
        vpc_id = string
        propagating_vgws = list(string)
        associated_routes = map(map(string))
        tags = map(string)
    }))
    default = null
}

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