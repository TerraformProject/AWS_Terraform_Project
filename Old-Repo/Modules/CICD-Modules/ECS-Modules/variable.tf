############################
## ECS Services Variables ##
############################

variable "create_ecs_services" {
    description = "Whether or not to create the ecs services"
    type = bool 
    default = false
}

## General Settings ##

variable "ecs_service_name" {
    description = "Name for the ECS Service"
    type = string
    default = null
}

variable "use_new_task_definition" {
    description = "Whether to use the newly created task definition from below"
    type = bool
    default = false
}

variable "task_definition_arn" {
    description = "Family:Revision or full ARN of the task definition to use"
    type = string
    default = null
}

variable "ecs_cluster" {
    description = "Name of the ECS Cluster to use"
    type = string
    default = null
}

variable "ecs_service_iam_role" {
    description = "The ARN of the IAM role for the ECS Service to call a loadbalancer"
    type = string
    default = null
}

## Launch Settings ##

variable "launch_type" {
    description = "The launch type for the ECS Service"
    type = string
    default = null
}

variable "platform_version" {
    description = "The platform version for the FARGATE launch type"
    type = string
    default = null
}


variable "deployment_controller_type" {
    description = "Type of deployment controller to use for the ECS Service"
    type = string
    default = null
}

variable "scheduling_strategy" {
    description = "The scheduling strategy to use for the ECS Service"
    type = string
    default = null
}

variable "deployment_maximum_percent" {
    description = "An upper-limit percentage from the desired count for tasks that can be running in a service during deployemnt"
    type = number
    default = null
}

variable "deployment_minimum_healthy_percent" {
    description = "A lower-limit percentage from the desired count for tasks that can be running in a service during deployemnt "
    type = number
    default = null
}

variable "desired_count" {
    description = "Number of instances of the task definition to place and keep running"
    type = number
    default = null
}

variable "health_check_grace_period_seconds" {
    description = "Number of seconds before the ECS Service starts receiving health checks from the load balancer"
    type = number
    default = null
}

variable "wait_for_steady_state" {
    description = "Whether if Terraform should wait unitl the service is steady before moving on"
    type = bool 
    default = null
}

variable "configure_service_registry" {
    description = "Whether a service registry should be configured for the ECS Service"
    type = bool
    default = null
}

variable "service_registry" {
    description = "Settings for the service registry for the ECS Service"
    type = map(object({
      registry_arn = string
      port = number
      container_port = number
      container_name = string
    }))
    default = {}
}

variable "enable_deployment_circuit_breaker_logic" {
    description = "Whether to enable circuit breaker logic for the ECS Service"
    type = bool
    default = false
}

variable "enable_ecs_rollback" {
    description = "Whether to enable ECS rollback for the ECS Service"
    type = bool
    default = false
}

variable "configure_capacity_provider_strategies" {
    description = "Whether to configure capacity provider strategies for the ECS Service"
    type = bool
    default = false
}

variable "capacity_provider_strategies" {
    description = "Settings for capacity provider strategies for the ECS Service"
    type = map(object({
        capacity_provider = string
        base = number
        weight = number
    }))
}

variable "configure_ordered_placement_strategy" {
    description = "Whether to configure ordered placement strategy for the ECS Service"
    type = bool
    default = false
}

variable "ordered_placement_strategy" {
    description = "Settings for the odered placement strategy"
    type = map(object({
        type = string
        field = string
    }))
    default = {}
}

variable "configure_load_balancers" {
    description = "Whether to configure load balancer for the ECS Service"
    type = bool
    default = false
}

variable "load_balancers" {
    description = "Settings for the load balancers for the ECS Service to use"
    type = map(object({
        elb_name = string
        target_group_arn = string
        container_name = string
        container_port = number
    }))
    default = {}
}

variable "configure_service_task_placement_constraints" {
    description = "Whether to configure placement constraints for the ECS Service"
    type = bool
    default = false
}

variable "service_task_placement_constraints" {
    description = "Settings for the placement constraints for the ECS Service"
    type = map(object({
        type = string
        expression = string
    }))
    default = {}
}

## Network Settings ##

variable "configure_network_configuration" {
    description = "Whether to configure network configuration for the ECS Service"
    type = bool
    default = false
}

variable "network_configuration" {
    description = "Settings for the network configuration"
    type = map(object({
        subnets = list(string)
        security_groups = list(string)
        assign_public_ip = bool
    }))
}

## Debug Settings ##

variable "enable_execute_command" {
    description = "Whether to enable the ECS Exec for the ECS Service"
    type = bool
    default = false 
}

## Overrwrite Settings ##

variable "force_new_deployment" {
    description = "Whether to force new task deployemnt for the ECS Service"
    type = bool
    default = false
}

## Tag Settings ##

variable "enable_ecs_managed_tags" {
    description = "Whether to enable ECS managed tags" 
    type = bool
    default = false
}

variable "propagate_tags" {
    description = "Where to propagate the tags"
    type = string
    default = null
}

variable "ecs_service_tags" {
    description = "Tags to associate with the ECS Service"
    type = map(string)
    default = {}
}


##########################
## ECS Task Definitions ##
##########################

variable "create_task_definition" {
    description = "Whether or not to create ecs tasl definitions"
    type = bool
    default = false
}

## General Settings ##

variable "family" {
    description = "Unique name for the task definition"
    type = string 
    default = null
}

variable "task_role_arn" {
    description = "ARN of the role given to the task definition to access specified AWS resources"
    type = string
    default = null
}

variable "execution_role_arn" {
    description = "ARN of the role the ECS container agent and Docker daemon can assume"
    type = string
    default = null
}

## System Settings ##

variable "ecs_cpu" {
    description = "Amount of CPU to allocate to the task definition"
    type = number
    default = null
}

variable "ecs_memory" {
    description = "Amount of memory to allocate to the task definition"
    type = number
    default = null
}

variable "ipc_mode" {
    description = "The mode of which containers share the same IPC (memory) resources"
    type = string
    default = null
}

variable "pid_mode" {
    description = "The mode of which containers share PID (System Processes) resources"
    type = string
    default = null
}

variable "requires_compatibilities" {
    description = "The environment of which the task definition may run in"
    type = set(string)
    default = null
}

variable "container_definitions" {
    description = "Local file path to a json document containing container definitions"
    type = string
    default = null
}

variable "container_definitions_env_vars" {
    description = "Environment Variables to be passed to container definitions file for automation"
    type = any
    default = {}
}

## GPU Settings ##

variable "configure_inference_accelerator" {
    description = "Whether to configure the inference accelerator for task definitions"
    type = bool
    default = false
}

variable "inference_accelerator" {
    description = "Config for the inference accelerator"
    type = map(map(string))
    default = {}
}

## Storage Settings ##

variable "volume_configurations" {
    description = "Settings for the columes to specify for the task definition"
    type = any
    default = {}
}

variable "configure_ephemeral_storage" {
    description = "Whether to configure the ephemeral storage"
    type = bool
    default = false
}

variable "ephemeral_storage" {
    description = "Amount of ephemeral storage (in GBs) to allocate"
    type = map(number)
    default = {}
}

## Network Settings ##

variable "network_mode" {
    description = "The network mode the container will be set in"
    type = string
    default = null
}

variable "configure_proxy_configuration" {
    description = "Whether to configure the proxy configuration"
    type = bool
    default = false
}

variable "proxy_configuration" {
    description = "Settings for the proxy configuration"
    type = map(object({
        type = string
        container_name = string
        properties = any
    }))
    default = {}
}

 ## Placement Settings ##

variable "configure_task_placement_constraints" {
    description = "Whether to confiure placement constraints"
    type = bool
    default = false
}

variable "task_placement_constraints" {
    description = "settings for configuring placement constraints"
    type = map(map(string))
    default = {}
}

 ## Tag Settings ##

variable "task_definition_tags" {
    description = "Tags to associate with the task definition"
    type = map(string)
    default = {}
}