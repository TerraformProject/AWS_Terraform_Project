################################
## Internet Gateway Variables ##
################################

variable "internet_gateways" {
    type = any
    default = {}
}

############################################
## Egress Only Internet Gateway Variables ##
############################################

variable "egress_internet_gateways" {
    type = any
    default = {}
}

##############################
## NAT Gateway Variables ##
##############################

variable "nat_gateways" {
    type = any
    default = {}
}


