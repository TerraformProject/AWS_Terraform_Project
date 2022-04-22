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