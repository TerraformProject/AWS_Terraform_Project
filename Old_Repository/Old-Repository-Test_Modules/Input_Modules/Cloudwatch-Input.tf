module "CLOUDWATCH_VPC1" {
    source = "../../../Modules/Security-Modules/Monitoring-Modules/Cloudwatch-Modules"

############################
## CloudWatch: Log Groups ##
############################

cloudwatch_log_groups = {
    log_group_1 = {
        name = "Log_Group_1"
        name_prefix = ""
        retention_in_days = 7 
        kms_key_id = "id-sdvsdg12355"

        tags = {
            "key" = "value"
        }
    }
}

#############################
## CloudWatch: Log Streams ##
#############################

cloudwatch_log_streams = {
    log_stream_1 = {
        name = "Log_stream_1"
        log_group_map_key_name = "log_group_1" 
    }
}

###############################
## CloudWatch: Metric Filter ##
###############################

cloudwatch_log_metric_filters = {
    metric_filter_1 = {
        name = "ErrorCount"
        pattern = ""
        log_group_map_key_name = "log_group_1" 
        metric_transformation = {
           metric = {
            name = "yuh"
            namespace = "12333" 
            value = "1"
            default_value = "ERROR"
           }
        }
    }
}

########################
## CloudWatch: Alarms ##
########################

cloudwatch_metric_alarms = {
    metric_alarm_1 = {
        alarm_name          = "terraform-test-foobar5"
        alarm_description = "this is an alarm description"
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods  = "2"
        metric_name         = "CPUUtilization"
        namespace           = "AWS/EC2"
      # period              = "120"
        statistic           = "Average"
      # extended_statistic = "" 
        unit = "Seconds"
        threshold           = "80"
      # threshold_metric_id = ""
        actions_enabled = true
        alarm_actions = []
        ok_actions = []
        insufficient_data_actions = []
        datapoints_to_alarm = 3
        
        dimensions = {}

        # metric_query = {
        #   metric_query_1 = {
        #     id = ""
        #     expression = ""
        #     label = ""
        #     return_data = false
        #     metric = {
        #         dimensions = {

        #         }
        #         metric_name = ""
        #         namespace = ""
        #         period = ""
        #         stat = ""
        #         unit = 1
        #         }
        #     }
        # }

        tags = {
            "key" = "value"
        } 
    }
}

#################################
## CloudWatch: Resource Policy ##
#################################

cloudwatch_resource_policies = {
    policy_1 = {
        policy_name = "TheYuhPolicy"
        principals = {
          principal_service = {
              identifiers = ["*"]
              type = "Service"
          }
        }
        actions = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:PutLogEventsBatch",
        ]
        resources = ["arn:aws:logs:*"]
        conditions = {
        #   condition_1 = {
        #       test = 
        #       values = 
        #       variable =
        #   }
        }
    }
}

########################################
## CloudWatch: Log Destination Policy ##
########################################
    
cloudwatch_log_destination_policies = {
    policy_1 = {
        destination_name = "TheYuhDestination"
        role_arn = ""
        target_arn = ""

        policy_name = "TheYuhPolicy"
        principals = {
          principal_service = {
              identifiers = ["*"]
              type = "Service"
          }
        }
        actions = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:PutLogEventsBatch",
        ]
        resources = ["arn:aws:logs:*"]
        conditions = {
        #   condition_1 = {
        #       test = 
        #       values = 
        #       variable =
        #   }
        }
    }
}


}