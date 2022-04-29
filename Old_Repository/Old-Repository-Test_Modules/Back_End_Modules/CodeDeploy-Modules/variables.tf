######################################
## CodeDeploy Application Variables ##
######################################

variable "create_codedeploy_app" {
    description = "Whether or not to create a codedeploy app"
    type = bool
    default = false
}

variable "app_compute_platform" {
    description = "Compute platform for the codedeploy app"
    type = string
    default = null
}

variable "app_name" {
    description = "Name for the codedeploy application"
    type = string
    default = null
}

variable "codedeploy_app_tags" {
    description = "Tags for the codedeploy application"
    type = map(string)
    default = null
}

############################################
## CodeDeploy Deployment Config Variables ##
############################################

variable "create_deployment_config" {
    description = "Whether or not to create a codedeploy deployment config"
    type = bool
    default = false
}

variable "deployment_config_name" {
    description = "Name for the deployment configuration"
    type = string
    default = null
}

variable "config_compute_platform" {
    description = "Compute platform for the codedeploy deployment configuration"
    type = string
    default = null
}

variable "create_minimum_healthy_hosts" {
    description = "Whether or not to create a create_minimum_healthy_hosts"
    type = bool
    default = false
}

variable "minimum_healthy_hosts" {
    description = "Settings for the minimum healthy host"
    type = map(object({
        type = string
        value = number
    }))
}

variable "create_traffic_routing_config" {
    description = "Whether or not to create_traffic_routing_config"
    type = bool
    default = false
}

variable "traffic_routing_config" {
    description = "Settings for the traffic routing config"
    type = map(object({
        type = string
        create_time_based_linear = bool
        time_based_linear = map(map(number))
        create_time_based_canary = bool
        time_based_canary = map(map(number))
    }))
}

###########################################
## CodeDeploy Deployment Group Variables ##
###########################################

variable "create_deployment_group" {
    description = "Whether or not to create a codedeploy deployment group"
    type = bool
    default = false
}

variable "codedeploy_app_name" {
    description = "Name of codedeploy application to use for codedeploy deployment group"
    type = string
    default = null
}

variable "deployment_group_name" {
    description = "Name for the codedeploy deployment group"
    type = string
    default = null
}

variable "deployment_config_for_group" {
    description = "The name of the deployment config to use for the deployment group"
    type = string
    default = null
}

variable "deployment_goup_service_role_arn" {
    description = "Service role ARN for the codedeploy deployment group"
    type = string
    default = null
}

variable "deployment_style" {
    description = "Deployment style for the codedeploy deployment group"
    type = map(string)
    default = {}
}

variable "create_ec2_tag_filter" {
    description = "Whether or not to create an EC2 tag filter"
    type = bool
    default = false
}

variable "ec2_tag_filter" {
    description = "settings for ec2_tag_filter"
    type = map(map(string))
    default = {}
}

variable "create_ecs_deployment" {
    description = "Whether or not to create an ecs deployment for the deployment group"
    type = bool
    default = false
}

variable "ecs_service" {
    description = "Setting for the ECS service to use for the codedeploy deployment group"
    type = map(map(string))
    default = {}
} 

variable "use_autoscaling_groups" {
    description = "Whether or not to use autoscaling groups for the deployment group to deploy to"
    type = bool
    default = false
}

variable "autoscaling_groups_for_deployment_group" {
    description = "Auto scaling groups for the deployment group to deploy to"
    type = list(string)
    default = null
}

variable "create_blue_green_deployment_config" {
    description = "Whether or not to create a blue green deployement config"
    type = bool
    default = false
}

variable "blue_green_deployment_config" {
    description = "Settings for the blue_green_deployemnt_config for the deployment group"
    type = map(object({
        create_deployment_ready_option = bool
        deployment_ready_option = map(object({
            action_on_timeout = string
            wait_time_in_minutes = number
        }))
        create_green_fleet_provisioning_option = bool
        green_fleet_provisioning_option = map(string)
        create_terminate_blue_instances_on_deployment_success = bool
        terminate_blue_instances_on_deployment_success = map(object({
            action = string
            termination_wait_time_in_minutes = number
        }))
    }))
    default = null
}

variable "create_load_balancer_info" {
    description = "Whether or not to create a load balancer infor for the deployment group"
    type = bool
    default = false
}

variable "load_balancer_info" {
    description = "Settings for the loadbalancer info for the deployemnt group"
    type = map(object({
        create_elb_info = bool
        elb_info = map(map(string))
        create_target_group_info = bool
        target_group_info = map(map(string))
        create_target_group_pair_info = bool
        target_group_pair_info = map(object({
            prod_traffic_route = map(list(string))
            target_group = map(string)
            create_test_traffic_route = bool
            test_traffic_route = map(list(string))
        }))
    }))
    default = null
}

variable "create_trigger_configuration" {
    description = "Whether or not to create a trigger configuration for the deployment group"
    type = bool
    default = false
}

variable "trigger_configuration" {
    description = "Setting for the trigger configuration"
    type = map(object({
        trigger_events = set(string)
        trigger_name = string
        trigger_target_arn = string
    }))
}

variable "create_auto_rollback_configuration" {
    description = "Whether or not to create an auto rollback configuraiton for the deployment group"
    type = bool
    default = false
}

variable "auto_rollback_configuration" {
    description = "Settings for the rollback configuration"
    type = map(object({
        enabled = bool
        events = set(string)
    }))
}

variable "create_alarm_configuration" {
    description = "Whether or not to create an alarm_configuration for the codedeploy deployment group"
    type = bool
    default = false
}

variable "alarm_configuration" {
    description = "Settngs for the alarm configuration for the deployment group"
    type = map(object({
        alarms = list(string)
        enabled = bool
        ignore_poll_alarm_failure = bool
    }))
    default = null
}

variable "deployment_group_tags" {
    description = "Tags for the deployemnt group"
    type = map(string)
    default = null
}