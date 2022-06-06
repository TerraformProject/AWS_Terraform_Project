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

variable "create_route_tables" {
  description = "Whether or not to create route tables for the VPC"
  type = bool
  default = false
}

variable "vpc_id" {
  description = "The VPC ID where these route tables will be created in"
  type = string
  default = ""
}

variable "route_tables" {
    description = "mapping of objects for the route tables to be created and the routes to be associated"
    type = map(object({
        route_table_name = string
        subnet_ids = list(string)
        propagating_vgws = list(string)
        associated_routes = map(object({
            destination = map(string)
            target = object({
                type = string
                new_target = bool
                target_values = any
            })
        }))
        # subnet_ids = list(string)
        # subnet_tags = map(string)
        route_table_tags = map(string)
    }))
    default = null
}