###################################
## Default Routes Variables ##
###################################

variable "manage_default_route_table" {
    type = bool
    default = false
}

variable "default_route_table_id" {
    type = string
    default = null
}

variable "default_route_table_propagating_vgws" {
    type = list(string)
    default = []
}

variable "default_route_table_routes" {
    type = map(string)
    default = {}
}

variable "default_route_table_name" {
    type = string
    default = ""
}

variable "default_route_table_tags" {
    type = map(string)
    default = {}
}

##################################
## Public Route Table Variables ##
##################################

variable "manage_public_route_table" {
    type = bool
    default = false
}

variable "Public_Route_Tables" {
    type = any
    default = {}
}

variable "vpc_id_for_public_route_table" {
    type = string
    default = null
}

variable "propagating_vgws_for_public_route_table" {
    type = list(string)
    default = []
}

variable "public_route_table_name" {
    type = string
    default = ""
}

variable "public_route_table_tags" {
    type = map(string)
    default = {}
}

##################################
## Private Route Table Variables ##
##################################
variable "Private_Route_Tables" {
    type = any
    default = {}
}

variable "vpc_id_for_private_route_table" {
    type = string
    default = null
}

variable "propagating_vgws_for_private_route_table" {
    type = list(string)
    default = []
}

variable "private_route_table_name" {
    type = string
    default = ""
}

variable "private_route_table_tags" {
    type = map(string)
    default = {}
}

##################################
## Database Route Table Variables ##
##################################

variable "manage_database_route_table" {
    type = bool
    default = false
}

variable "Database_Route_Tables" {
    type = any
    default = {}
}

variable "vpc_id_for_database_route_table" {
    type = string
    default = null
}

variable "propagating_vgws_for_database_route_table" {
    type = list(string)
    default = []
}

variable "database_route_table_name" {
    type = string
    default = ""
}

variable "database_route_table_tags" {
    type = map(string)
    default = {}
}