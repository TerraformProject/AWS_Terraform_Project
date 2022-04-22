############################
## CloudWatch: Log Groups ##
############################

variable "cloudwatch_log_groups" {
  description = "Mapping of objects for log groups to be create"
  type = map(object({
      name = string
      name_prefix = string
      retention_in_days = number
      kms_key_id = string
      tags = map(string)
  }))
  default = null
}

#############################
## CloudWatch: Log Streams ##
#############################

variable "cloudwatch_log_streams" {
    description = "Mapping of objects for log streams to be created"
    type = map(any)
    default = null
}

###############################
## CloudWatch: Metric Filter ##
###############################

variable "cloudwatch_log_metric_filters" {
    description = "Mapping of objects for metric filters for log groups"
    type = map(any)
}

##################################
## CloudWatch: Alarms Variables ##
##################################

variable "cloudwatch_metric_alarms" {
  description = "Mapping of objects for the metric alarms"
  type = map(any)
  default = null
}

###########################################
## CloudWatch: Resource Policy Variables ##
###########################################

variable "cloudwatch_resource_policies" {
  description = "Mapping of policies for the resource policies"
  type = map(any)
  default = null
}

##########################################
## CloudWatch: Log Destination Policies ##
##########################################

variable "cloudwatch_log_destination_policies" {
  description = "Mapping of policies for the log destination policies"
  type = map(any)
  default = null
}