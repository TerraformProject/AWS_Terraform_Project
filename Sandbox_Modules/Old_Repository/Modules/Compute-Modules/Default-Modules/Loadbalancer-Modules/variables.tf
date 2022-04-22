########################################
## Application Loadbalancer Variables ##
########################################

variable "create_load_balancer" {
  description = "Whether a loadbalancer should be created"
  type = bool
  default = false
}

variable "load_balancer_name" {
  description = "Name of App LB"
  type = string
  default = ""
}

variable "use_name_prefix" {
  description = "Whether the load balancer name should use a name prefix"
  type = bool
  default = false
}

variable "load_balancer_environment" {
  description = "The environment the app LB will be placed in"
  type = string
  default = ""
}

variable "load_balancer_type" {
  description = "The type of load balancer"
  type = string
  default = null
}

variable "internal_load_balancer" {
  description = "Whether the LB should be public or private"
  type = bool
  default = false
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection should be enabled for the load balancer"
  type = bool
  default = false
}

## Application Load Balancer Variable ##

variable "application" {
  description = "Settings for the load balancer if the lb_type variable == application"
  type = map(object({
    existing_subnets = list(string)
    new_subnet_keys = list(string)
    existing_security_groups = list(string)
    new_security_group_keys = list(string)
    ip_address_type = string
    customer_owned_ipv4_pool = string
    enable_http2 = bool
    drop_invalid_header_fields = bool
    idle_timeout = number
  }))
  default = null
}

## Network Load Balancer Variable ##

variable "network" {
  description = "Settings for the load balancer if the lb_type variable == network"
  type = map(object({
    existing_subnets = list(string) 
    new_subnet_keys = list(string)
    customer_owned_ipv4_pool = string
    ip_address_type = string
    enable_cross_zone_load_balancing = bool
  }))
  default = null
}

## Gateway Load Balancer Variable ##

variable "gateway" {
  description = "Settings for the load balancer if the lb_type variable == gateway"
  type = map(object({
    existing_subnets = list(string)
    new_subnet_keys = list(string)
    customer_owned_ipv4_pool = string
    ip_address_type = string
  }))
}

## Create New Subnet Variables ##
variable "create_new_subnets" {
  description = "Whether to create new subnets for the load balancer"
  type = bool
  default = false
}

variable "new_subnets" {
  description = "Settings for new subnets for the load balancer"
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
    route_table_id_association = string
    tags = map(string)
  }))
}

## Create New Security Groups Variable ##
variable "create_new_security_groups" {
  description = "Whether to create new security groups for the load balancer"
  type = bool
  default = false
}

variable "new_security_groups" {
  description = "Settings for the security groups to add to the load balancer"
  type = map(object({
    name = string
    description = string
    vpc_id = string
    ingress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      self = bool
    }))
    egress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      self = bool
    }))
    tags = map(string)
  }))
  default = {}
}

## Subnet Mapping Variables ##

variable "create_subnet_mapping" {
  description = "Whether or not to create subnet mapping for the load balancer"
  type = bool
  default = false
}

variable "subnet_mapping" {
  description = "Setting for the subnet mapping for the load balancer"
  type = map(map(string))
  default = {}
}

## Access Logs Variables ##

variable "create_s3_access_logs" {
  description = "Whether to create access logs for the load balancer"
  type = bool
  default = false
}

variable "s3_access_logs" {
  description = "Settings for the access logs for the load balancer"
  type = map(object({
    bucket = string
    prefix = string
    enable = bool
  }))
  default = {}
}

variable "load_balancer_tags" {
  description = "Tags to associate with the load balancer"
  type = map(string)
  default = {}
}

######################################
## Load Balancer Listeners Variable ##
######################################

variable "create_listeners" {
  description = "Whether to create listeners for the load balancer"
  type = bool
  default = false
}

variable "listeners" {
  description = "Settings for the listeners of the load balancer"
  type = map(object({
    port = number
    protocol = string
    use_ssl_certificate = bool
    ssl_certificates = object({
      default_certificate = map(string)
    })
    use_additional_ssl_certificates = bool
    additional_certificates = map(map(string))
    default_actions = any
  }))
  default = null
}

############################################
## Load Balancer Listeners Rules Variable ##
############################################

variable "create_listener_rules" {
  description = "Whether to create listener rules for the load balancer"
  type = bool
  default = false
}

variable "listener_rules" {
  description = "Listener rules for the load balancer"
  type = map(object({
    listener_map_key_name = string
    priority = number
    actions = any
    conditions = any
  }))
  default = {}
  
}


