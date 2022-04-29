locals {
    rules = flatten( [ for target_rule in var.cloudwatch_rule_target: target_rule.rule ] )

    targets = flatten( [ for target_target in var.cloudwatch_rule_target: target_target.target ] )
}

############################
## CloudWatch Event Buses ##
############################

resource "aws_cloudwatch_event_bus" "bus" {
for_each = var.create_new_event_buses == true ? var.new_event_buses : {}
  name              = lookup(each.value, "name", "")
}

###########################
## CloudWatch Event Rule ##
###########################

resource "aws_cloudwatch_event_rule" "rules" {
for_each = { for o in local.rules: "${o.name}.${o.description}.${o.is_enabled}.${o.role_arn}.${o.event_bus_name}" => o }

  name        = each.value.name
  # name_prefix = ""
  description = each.value.description
  is_enabled = each.value.is_enabled
  role_arn = each.value.role_arn
  event_bus_name = each.value.event_bus_name == "" ? null : aws_cloudwatch_event_bus.bus[each.value.event_bus_name].name 

  #schedule_expression = each.value.schedule_expression

  event_pattern = element([ for o in local.rules: o.event_pattern ], 0)
  
  tags = element([ for o in local.rules: o.tags ], 0)
}

#############################
## CloudWatch Event Target ##
#############################

resource "aws_cloudwatch_event_target" "targets" {
for_each = { for o in local.targets: "${o.associated_rule_name}.${o.target_id}.${o.arn}.${o.event_bus_name}.${o.role_arn}" => o } 

  target_id = each.value.target_id
  rule      = each.value.associated_rule_name
  arn       = each.value.arn
  event_bus_name = each.value.event_bus_name == "" ? null : aws_cloudwatch_event_bus.bus[each.value.event_bus_name].name
  role_arn = each.value.role_arn

  # input = element([ for o in local.targets: o.input ], 0)
  # input_path = element([ for o in local.targets: o.input_path ], 0)

  dynamic "run_command_targets" {
    for_each = [ for k, v in each.value: v if k == "run_command_targets" ] 
    content{
        key    = element([ for k, v in run_command_targets.value: v if k == "key" ], 0)
        values = element([ for k, v in run_command_targets.value: v if k == "values" ], 0)
        }
    }

  dynamic "ecs_target" {
    for_each = [ for k, v in each.value: v if k == "ecs_target" ]
    content{
        group = element([ for k, v in ecs_target.value: v if k == "group" ], 0)
        launch_type = element([ for k, v in ecs_target.value: v if k == "launch_type" ], 0)
        platform_version = element([ for k, v in ecs_target.value: v if k == "platform_version" ], 0)
        task_count = element([ for k, v in ecs_target.value: v if k == "task_count" ], 0)
        task_definition_arn = element([ for k, v in ecs_target.value: v if k == "task_definition_arn" ], 0)
        dynamic "network_configuration" {
        for_each = [ for k, v in ecs_target.value : v if k == "network_configuration" ]
        content {
            subnets = element([ for k, v in network_configuration.value: v if k == "subnets" ], 0)
            security_groups = element([ for k, v in network_configuration.value: v if k == "security_groups" ], 0)
            assign_public_ip = element([ for k, v in network_configuration.value: v if k == "assign_public_ip" ], 0)
          }
        }
      }
    }
    
  dynamic "batch_target" {
    for_each = [ for k, v in each.value: v if k == "batch_target" ]
    content {
        job_definition = element([ for k, v in batch_target.value: v if k == "job_definition" ], 0)
        job_name = element([ for k, v in batch_target.value: v if k == "job_name" ], 0)
        array_size = element([ for k, v in batch_target.value: v if k == "array_size" ], 0) == 0 ? null : element([ for k, v in batch_target.value: v if k == "array_size" ], 0)
        job_attempts = element([ for k, v in batch_target.value: v if k == "job_attempts" ], 0)
    }
  }

  dynamic "kinesis_target" {
    for_each = [ for k, v in each.value: v if k == "kinesis_target" ]
    content {
        partition_key_path = element([ for k, v in kinesis_target.value: v if k == "partition_key_path" ], 0)
    }
  }

  dynamic "sqs_target" {
    for_each = [ for k, v in each.value: v if k == "sqs_target" ]
    content {
        message_group_id = element([ for k, v in sqs_target.value: v if k == "message_group_id" ], 0)
    }
  }
  
  dynamic "input_transformer" {
    for_each = [ for k, v in each.value: v if k == "input_transformer" ]
    content {
        input_paths = element([ for k, v in input_transformer.value: v if k == "input_paths" ], 0)
        input_template = element([ for k, v in input_transformer.value: v if k == "input_template" ], 0)
    }
  }

  dynamic "retry_policy" {
    for_each = [ for k, v in each.value: v if k == "retry_policy" ]
    content {
        maximum_event_age_in_seconds = element([ for k, v in retry_policy.value: v if k == "maximum_event_age_in_seconds" ], 0)
        maximum_retry_attempts = element([ for k, v in retry_policy.value: v if k == "maximum_retry_attempts" ], 0)
    }
  }

  dynamic "dead_letter_config" {
    for_each = [ for k, v in each.value: v if k == "dead_letter_config" ]
    content {
        arn = element([ for k, v in dead_letter_config.value: v if k == "arn" ], 0)
    }
  }
}

##########################################
## CloudWatch Sender Account Permission ##
##########################################

resource "aws_cloudwatch_event_permission" "SendAccountPerm" {
for_each = var.create_sender_account_permission == true ? var.sender_account_permissions : {}
  principal    = lookup(each.value, "principal", null)
  statement_id = lookup(each.value, "statement_id", null)
  action = lookup(each.value, "action", null)
  event_bus_name = lookup(each.value, "event_bus_name", "" ) == "" ? null : aws_cloudwatch_event_bus.bus[lookup(each.value, "event_bus_name", "" )].name
}