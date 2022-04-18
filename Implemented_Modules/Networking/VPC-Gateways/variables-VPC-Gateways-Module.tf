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