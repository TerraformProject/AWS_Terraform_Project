
############################
## CodeDeploy Application ##
############################

resource "aws_codedeploy_app" "codedeploy_app" {
count = var.create_codedeploy_app == true ? 1 : 0
  compute_platform = var.app_compute_platform
  name             = var.app_name

  tags = var.codedeploy_app_tags
}

##################################
## CodeDeploy Deployment Config ##
##################################

resource "aws_codedeploy_deployment_config" "deploy_config" {
count = var.create_deployment_config == true ? 1 : 0

  deployment_config_name = var.deployment_config_name
  compute_platform       = var.config_compute_platform

    dynamic "minimum_healthy_hosts" {
    for_each = var.create_minimum_healthy_hosts == true ? var.minimum_healthy_hosts : {}
    content {
        type = lookup(minimum_healthy_hosts.value, "type", null )
        value = lookup(minimum_healthy_hosts.value, "value", null )
        }
    }

    dynamic "traffic_routing_config" {
        for_each = var.create_traffic_routing_config == true ? var.traffic_routing_config : {}
        content {
        type = lookup(traffic_routing_config.value, "type", null )

        dynamic "time_based_linear" {
        for_each = lookup(traffic_routing_config.value, "create_time_based_linear", false ) == true ? lookup(traffic_routing_config.value, "time_based_linear", {} ) : {}   
        content {
          interval   = lookup(time_based_linear.value, "interval", null )
          percentage = lookup(time_based_linear.value, "percentage", null) 
        }
    }

        dynamic "time_based_canary" {
        for_each = lookup(traffic_routing_config.value, "create_time_based_canary", false ) == true ? lookup(traffic_routing_config.value, "time_based_canary", {} ) : {} 
        content { 
          interval   = lookup(time_based_canary.value, "interval", null )
          percentage = lookup(time_based_canary.value, "percentage", null )
        }
      }
    }
  }

  depends_on = [
    aws_codedeploy_app.codedeploy_app
  ]

}

#################################
## CodeDeploy Deployment Group ##
#################################

resource "aws_codedeploy_deployment_group" "deployment_group" {
count = var.create_deployment_group == true ? 1 : 0

  app_name              = var.codedeploy_app_name
  deployment_group_name = var.deployment_group_name 
  deployment_config_name = var.deployment_config_for_group
  service_role_arn      = var.deployment_goup_service_role_arn
  

  deployment_style {
    deployment_option = var.deployment_style["deployment_option"]
    deployment_type   = var.deployment_style["deployment_type"]
  }

  dynamic "ec2_tag_filter" {
    for_each = var.create_ec2_tag_filter == true ? var.ec2_tag_filter : {}
    content {
        key = lookup(ec2_tag_filter.value, "key", null )
        type = lookup(ec2_tag_filter.value, "type", null )
        value = lookup(ec2_tag_filter.value, "value", null )
        } 
    }

  dynamic "ecs_service" {
    for_each = var.create_ecs_deployment == true ? var.ecs_service : {}
    content {
        cluster_name = lookup(ecs_service.value, "cluster_name", null )
        service_name = lookup(ecs_service.value, "service_name", null )
    }
  }

  dynamic "blue_green_deployment_config" {
    for_each = var.create_blue_green_deployment_config == true ? var.blue_green_deployment_config : {}
    content {
        dynamic "deployment_ready_option" {
        for_each = lookup(blue_green_deployment_config.value, "create_deployemnt_ready_option", false) == true ? lookup(blue_green_deployment_config.value, "deployment_ready_option", false) : {}
        content {
          action_on_timeout    = lookup(deployment_ready_option.value, "action_on_timeout", null)
          wait_time_in_minutes = lookup(deployment_ready_option.value, "wait_time_in_minutes", null)
          }
        }

        dynamic "green_fleet_provisioning_option" {
        for_each = lookup(blue_green_deployment_config.value, "create_green_fleet_provisioning_option", null) == true ? lookup(blue_green_deployment_config.value, "green_fleet_provisioning_option", null) : {}
        content {
        action = lookup(green_fleet_provisioning_option.value, "action", null)
          }
        }

        dynamic "terminate_blue_instances_on_deployment_success" {
        for_each = lookup(blue_green_deployment_config.value, "create_terminate_blue_instances_on_deployment_success", null) == true ? lookup(blue_green_deployment_config.value, "terminate_blue_instances_on_deployment_success", null) : {}
        content {
        action = lookup(terminate_blue_instances_on_deployment_success.value, "action", null)
        termination_wait_time_in_minutes = lookup(terminate_blue_instances_on_deployment_success.value, "termination_wait_time_in_minutes", null)
          }
        }
    }
  }

  autoscaling_groups = var.use_autoscaling_groups == true ? var.autoscaling_groups_for_deployment_group : null

  dynamic "load_balancer_info" {
      for_each = var.create_load_balancer_info == true ? var.load_balancer_info : {}
      content {
          dynamic "elb_info" {
              for_each = lookup(load_balancer_info.value, "create_elb_info", false) == true ? lookup(load_balancer_info.value, "elb_info", {}) : {}
              content {
                  name = lookup(elb_info.value, "action", null)
              }
          }
          dynamic "target_group_info" {
              for_each = lookup(load_balancer_info.value, "create_target_group_info", false) == true ? lookup(load_balancer_info.value, "target_group_info", {} ) : {}
              content {
                  name = lookup(target_group_info.value, "name", null )
              }
          }
          dynamic "target_group_pair_info" {
              for_each = lookup(load_balancer_info.value, "create_target_group_pair_info", false ) == true ? lookup(load_balancer_info.value, "target_group_info_pair", {} ) : {}
              content {
                  prod_traffic_route {
                      listener_arns = lookup(target_group_pair_info.value, "listener_arns", null ) 
                  }
                  target_group {
                      name = lookup(target_group_pair_info.value, "name")
                  }
                  dynamic "test_traffic_route" {
                    for_each = lookup(target_group_pair_info.value, "create_test_traffic_route", false ) == true ? lookup(target_group_pair_info.value, "test_traffic_route", {} ) : {}
                    content {
                      listener_arns = lookup(test_traffic_route.value, "listener_arns", [] )
                    } 
                  }
              }
          }
      }
  }

  dynamic "trigger_configuration" {
    for_each = var.create_trigger_configuration == true ? var.trigger_configuration : {}
      content {
          trigger_events = lookup(trigger_configuration.value, "trigger_events", null )
          trigger_name = lookup(trigger_configuration.value, "trigger_name", null )
          trigger_target_arn = lookup(trigger_configuration.value, "trigger_target_arn", null )
      }
  }

  dynamic "auto_rollback_configuration" {
    for_each = var.create_auto_rollback_configuration == true ? var.auto_rollback_configuration : {}
      content {
        enabled = lookup(auto_rollback_configuration.value, "enabled", null )
        events = lookup(auto_rollback_configuration.value, "events", null )
    }
  }

  dynamic "alarm_configuration" {
    for_each = var.create_alarm_configuration == true ? var.alarm_configuration : {}
      content {
          alarms = lookup(alarm_configuration.value, "alarms", null )
          enabled = lookup(alarm_configuration.value, "enabled", null )
          ignore_poll_alarm_failure = lookup(alarm_configuration.value, "ignore_poll_alarm_failure", null )
      }
  }

tags = var.deployment_group_tags

  depends_on = [
    aws_codedeploy_deployment_config.deploy_config,
    aws_codedeploy_app.codedeploy_app
  ]

}
