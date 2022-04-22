##################################
## Availability Zones Variables ##
##################################

variable "include_all_availability_zones" {
    type = bool
    default = false
}

variable "filter_az_by_state" {
    type = string
    default = ""
}

variable "filter_az_by_name_value" {
    type = map(string)
    default = {}
}

variable "excluded_zone_names" {
    type = list(string)
    default = []
}

variable "excluded_zone_ids" {
    type = list(string)
    default = []
}

##############################
## Public Subnets Variables ##
##############################

variable "public_subnets" {
    type = any
    default = {}
}

##############################
## Private Subnets Variables ##
##############################

variable "private_subnets" {
    type = any
    default = {}
}

##############################
## Database Subnets Variables ##
##############################

variable "database_subnets" {
    type = any
    default = {}
}






