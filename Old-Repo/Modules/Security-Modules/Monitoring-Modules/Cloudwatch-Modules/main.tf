###########################
## CloudWatch: Log Group ##
###########################

resource "aws_cloudwatch_log_group" "yada" {
for_each = var.cloudwatch_log_groups

  name = lookup(var.cloudwatch_log_groups[each.key], "name", null)
  name_prefix = lookup(var.cloudwatch_log_groups[each.key], "name_prefix", null) == "" ? null : lookup(var.cloudwatch_log_groups[each.key], "name_prefix", null)
  retention_in_days = lookup(var.cloudwatch_log_groups[each.key], "retention_in_days", null)
  kms_key_id = lookup(var.cloudwatch_log_groups[each.key], "kms_key_id", null)

  tags = lookup(var.cloudwatch_log_groups[each.key], "tags", null)
}

############################
## CloudWatch: Log Stream ##
############################

resource "aws_cloudwatch_log_stream" "foo" {
  for_each = var.cloudwatch_log_streams
  name           = "SampleLogStream1234"
  log_group_name = aws_cloudwatch_log_group.yada[lookup(var.cloudwatch_log_streams[each.key], "log_group_map_key_name", "" )].name
}

###############################
## CloudWatch: Metric Filter ##
###############################

resource "aws_cloudwatch_log_metric_filter" "yada" {
for_each = var.cloudwatch_log_metric_filters

  name           = lookup(var.cloudwatch_log_metric_filters[each.key], "name", null)
  pattern        = lookup(var.cloudwatch_log_metric_filters[each.key], "pattern", null)
  log_group_name = aws_cloudwatch_log_group.yada[lookup(var.cloudwatch_log_metric_filters[each.key], "log_group_map_key_name", "")].name

  dynamic "metric_transformation" {
    for_each = lookup(var.cloudwatch_log_metric_filters[each.key], "metric_transformation", {} )
    content{
    name      = lookup(metric_transformation.value, "name", null)
    namespace = lookup(metric_transformation.value, "namespace", null)
    value     = lookup(metric_transformation.value, "value", null)
    }
  }
}

#######################
## CloudWatch: Alarm ##
#######################

# Works with Auto Scaling groups

resource "aws_cloudwatch_metric_alarm" "bat" {
  for_each = var.cloudwatch_metric_alarms

  alarm_name          = lookup(var.cloudwatch_metric_alarms[each.key], "alarm_name", null)
  alarm_description = lookup(var.cloudwatch_metric_alarms[each.key], "alarm_description", null)
  comparison_operator = lookup(var.cloudwatch_metric_alarms[each.key], "comparison_operator", null)
  evaluation_periods  = lookup(var.cloudwatch_metric_alarms[each.key], "evaluation_periods", null)
  metric_name         = lookup(var.cloudwatch_metric_alarms[each.key], "metric_name", null)
  namespace           = lookup(var.cloudwatch_metric_alarms[each.key], "namespace", null)
# period              = lookup(var.cloudwatch_metric_alarms[each.key], "period", null)
  statistic           = lookup(var.cloudwatch_metric_alarms[each.key], "statistic", null)
# extended_statistic =  lookup(var.cloudwatch_metric_alarms[each.key], "extended_statistic", null)
  unit = lookup(var.cloudwatch_metric_alarms[each.key], "unit", null)
  threshold           = lookup(var.cloudwatch_metric_alarms[each.key], "threshold", null)
# threshold_metric_id = lookup(var.cloudwatch_metric_alarms[each.key], "threshold_metric_id", null) == "" ? null : lookup(var.cloudwatch_metric_alarms[each.key], "threshold_metric_id", null)
  actions_enabled = lookup(var.cloudwatch_metric_alarms[each.key], "actions_enabled", null)
  alarm_actions = lookup(var.cloudwatch_metric_alarms[each.key], "alarm_actions", null)
  ok_actions = lookup(var.cloudwatch_metric_alarms[each.key], "ok_actions", null)
  insufficient_data_actions = lookup(var.cloudwatch_metric_alarms[each.key], "insufficient_data_actions", null)
  datapoints_to_alarm = lookup(var.cloudwatch_metric_alarms[each.key], "datapoints_to_alarm", null)

  dynamic "metric_query" {
    for_each = lookup(var.cloudwatch_metric_alarms[each.key], "metric_query", {} )
    content {
      id = lookup(metric_query.value, "id", null)
      expression = lookup(metric_query.value, "expression", null)
      label = lookup(metric_query.value, "label", null)
      return_data = lookup(metric_query.value, "return_data", null)
      dynamic "metric" {
      for_each = [ for metric in metric_query.value: metric if metric == {} ]
      content{
        dimensions = lookup(metric.value, "dimensions", null)
        metric_name = lookup(metric.value, "metric_name", null)
        namespace = lookup(metric.value, "namespace", null)
        period = lookup(metric.value, "period", null)
        stat = lookup(metric.value, "stat", null)
        unit = lookup(metric.value, "unit", null)
      }
    } 
  }
}

  # dimensions = lookup(var.cloudwatch_metric_alarms[each.key], "dimensions", null) 

  tags = lookup(var.cloudwatch_metric_alarms[each.key], "tags", null)
}

#################################
## CloudWatch: Resource Policy ##
#################################

data "aws_iam_policy_document" "cloudwatch_policy_document" {
for_each = var.cloudwatch_resource_policies
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["arn:aws:logs:*"]

    dynamic "principals" {
    for_each = lookup(var.cloudwatch_resource_policies[each.key], "principals", null )
      content{
      identifiers = lookup(principals.value, "identifiers", null)
      type        = lookup(principals.value, "type", null)
      }
    }
    dynamic "condition" {
      for_each = lookup(var.cloudwatch_resource_policies[each.key], "conditions", null )
      content {
        test = lookup(condition.value, "test", null)
        values = lookup(condition.value, "values", null)
        variable = lookup(condition.value, "variable", null)
      }
    } 
  }
}

resource "aws_cloudwatch_log_resource_policy" "cloudwwatch_policy" {
  for_each = var.cloudwatch_resource_policies

  policy_document = data.aws_iam_policy_document.cloudwatch_policy_document[each.key].json
  policy_name     = lookup(var.cloudwatch_resource_policies[each.key], "policy_name", null)
}

##########################################
## CloudWatch: Log Destination Policies ##
##########################################

# Will need to create Kinesis service for this portion

resource "aws_cloudwatch_log_destination" "test_destination" {
for_each = var.cloudwatch_log_destination_policies

  name       = lookup(var.cloudwatch_log_destination_policies[each.key], "destination_name", null)
  role_arn   = lookup(var.cloudwatch_log_destination_policies[each.key], "role_arn", null)
  target_arn = lookup(var.cloudwatch_log_destination_policies[each.key], "target_arn", null)
}

data "aws_iam_policy_document" "destination_policy" {
for_each = var.cloudwatch_log_destination_policies
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["arn:aws:logs:*"]

    dynamic "principals" {
    for_each = lookup(var.cloudwatch_log_destination_policies[each.key], "principals", null )
      content{
      identifiers = lookup(principals.value, "identifiers", null)
      type        = lookup(principals.value, "type", null)
      }
    }
    dynamic "condition" {
      for_each = lookup(var.cloudwatch_log_destination_policies[each.key], "conditions", null )
      content {
        test = lookup(condition.value, "test", null)
        values = lookup(condition.value, "values", null)
        variable = lookup(condition.value, "variable", null)
      }
    } 
  }
}

resource "aws_cloudwatch_log_destination_policy" "test_destination_policy" {
  for_each = var.cloudwatch_log_destination_policies
  destination_name = lookup(var.cloudwatch_log_destination_policies[each.key], "destination_name", null)
  access_policy    = data.aws_iam_policy_document.destination_policy[each.key].json
}





