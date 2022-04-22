##################################
## VPC1: Default NACl Varaibles ##
##################################

variable "default_network_acl" {
    type = any
    default = {}
}

##################################
## VPC1: Public NACl  Variables ##
##################################

variable "public_network_acl" {
    type = any
    default = {}
}

##################################
## VPC1: Private NACl Variables ##
##################################

variable "private_network_acl" {
    type = any
    default = {}
}

###################################
## VPC1: Database NACl Variables ##
###################################

variable "database_network_acl" {
    type = any
    default = {}
}