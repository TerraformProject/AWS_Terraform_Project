locals {

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## Creating all in one object for resources below to reference #

## GET INSTANCE BOOT VALUES ##
instance_boot = flatten([ for Instance_Boot_Keys, Instance_Boot_Values in var.Instance_Boot: 
                          [ for configs, config_values in Instance_Boot_Values.configurations: {
                              Instance_Boot = config_values
                          } 
                          if Instance_Boot_Values.enabled_config_index_key == config ]
                        ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET INSTANCE TYPE VALUES ##
instance_types = flatten([ for Instance_Type_Keys, Instance_Type_Values in var.Instance_Types: 
                          [ for config, config_values in Instance_Type_Values.configurations: {
                              Instance_Types = config_values
                          } 
                          if Instance_Type_Values.enabled_config_index_key == config ]
                        ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET INSTANCE CPU VALUES ##
instance_cpu = flatten([ for Instance_CPU_Keys, Instance_CPU_Values in var.Instance_CPU: 
                          [ for config, config_values in Instance_CPU_Values.configurations: {
                              Instance_CPU = config_values
                          } 
                          if Instance_CPU_Values.enabled_config_index_key == config ]
                        ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET INSTANCE MEMORY VALUES ##
instance_memory = flatten([ for Instance_Memory_Keys, Instance_Memory_Values in var.Instance_Memory: 
                          [ for config, config_values in Instance_Memory_Values.configurations: {
                              Instance_Memory = config_values
                          } 
                          if Instance_Memory_Values.enabled_config_index_key == config ]
                        ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET INSTANCE GPU VALUES ##
instance_gpu = flatten([ for Instance_GPU_Keys, Instance_GPU_Values in var.Instance_GPU: 
                          [ for config, config_values in Instance_GPU_Values.configurations: {
                              Instance_GPU = config_values
                          } 
                          if Instance_GPU_Values.enabled_config_index_key == config ]
                        ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET INSTANCE ACCELERATOR VALUES ##
instance_accelerators = flatten([ for Instance_Accelerator_Keys, Instance_Accelerator_Values in var.Instance_Accelerators: 
                          [ for config, config_values in Instance_Accelerator_Values.configurations: {
                              Instance_Accelerators = config_values
                          } 
                          if Instance_Accelerator_Values.enabled_config_index_key == config ]
                        ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET INSTANCE STORAGE ##
instance_storage = flatten([ for Instance_Storage_Keys, Instance_Storage_Values in var.Instance_Storage: 
                          [ for config, config_values in Instance_Storage_Values.configurations: {
                              Instance_Storage = config_values
                          } 
                          if Instance_Storage_Values.enabled_config_index_key == config ]
                        ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET INSTANCE NETWORKING VALUES ##
instance_networking = flatten([ for Instance_Networking_Keys, Instance_Networking_Values in var.Instance_Networking: 
                          [ for config, config_values in Instance_Networking_Values.configurations: {
                              Instance_Networking = config_values
                          } 
                          if Instance_Networking_Values.enabled_config_index_key == config ]
                        ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## MERGING ALL LAUNCH TEMPLATE VAlUES INTO LOCAL VARIABLED FOR REFERENCE BY RESOURCES ##
# launch_template = { 
#    lt_values = join(", ", concat(local.instance_boot, local.instance_types, local.instance_cpu, local.instance_memory, local.instance_gpu, local.instance_accelerators, local.instance_storage, local.instance_networking ) ) 
#    }

launch_template = {
  lt_values = merge(
      element(local.instance_boot, 0 ),
      element(local.instance_types, 0 ),
      element(local.instance_cpu, 0 ),
      element(local.instance_memory, 0 ),
      element(local.instance_gpu, 0 ),
      element(local.instance_accelerators, 0 ),
      element(local.instance_storage, 0 ),
      element(local.instance_networking, 0 )
  )

}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES WHEN copy_ami IS SPECIFIED -#
  copy_ami = flatten([ for Instance_Boot_Keys, Instance_Boot_Values in var.Instance_Boot: 
                      [ for config, config_values in Instance_Boot_Values.configurations: {
                          new_ami_name = lookup( config_values.get_ami_values, "new_ami_name", "" )
                          description = lookup( config_values.get_ami_values, "description", "" )
                          source_ami_id = lookup( config_values.get_ami_values, "source_ami_id", "" )
                          source_ami_region = lookup( config_values.get_ami_values, "source_ami_region", "" )
                          destination_outpost_arn = lookup( config_values.get_ami_values, "destination_outpost_arn", "" )
                          encrypted = lookup( config_values.get_ami_values, "encrypted", false )
                          kms_key_id = lookup( config_values.get_ami_values, "kms_key_id", "" )
                          tags = lookup( config_values.get_ami_values, "copy_ami_tags", {} )
                      }
                    if Instance_Boot_Values.enabled_config_index_key == config && config_values.get_ami_type == "copy_ami"
                    ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES WHEN copy_ami_instance IS SPECIFIED -#
  copy_ami_instance = flatten([ for Instance_Boot_Keys, Instance_Boot_Values in var.Instance_Boot: 
                                  [ for config, config_values in Instance_Boot_Values.configurations: {
                                      new_ami_name = lookup( config_values.get_ami_values, "new_ami_name", "" )
                                      source_instance_id = lookup( config_values.get_ami_values, "source_instance_id", "" )
                                      snapshot_without_reboot = lookup( config_values.get_ami_values, "snapshot_without_reboot", false )
                                      tags = lookup( config_values.get_ami_values, "copy_ami_instance_tags", {} )
                                  }
                                if Instance_Boot_Values.enabled_config_index_key == config && config_values.get_ami_type == "copy_ami_instance"
                                ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

# - GET VALUES WHEN CREATING A NEW IAM INSTANCE PROFILE -#
  iam_instance_profile = flatten([ for Instance_Boot_Keys, Instance_Boot_Values in var.Instance_Boot: 
                                  [ for config, config_values in Instance_Boot_Values.configurations: {
                                      instance_profile_name = config_values.iam_instance_profile.instance_profile_name
                                      path = config_values.iam_instance_profile.path
                                      policy_file = config_values.iam_instance_profile.policy_file
                                  }
                                if Instance_Boot_Values.enabled_config_index_key == config && config_values.iam_instance_profile.instance_profile_name != ""
                                ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES WHEN SPECIFYING A NEW KEY PAIR FOR LAUNCH TEMPLATE -#
  key_pair = flatten([ for Instance_Boot_Keys, Instance_Boot_Values in var.Instance_Boot: 
                      [ for config, config_values in Instance_Boot_Values.configurations: {
                          new_key_pair_name = config_values.ssh_key_pair.new_key_pair_name
                          public_key_file = config_values.ssh_key_pair.public_key_file
                      }
                    if Instance_Boot_Values.enabled_config_index_key == config && config_values.ssh_key_pair.public_key_file != ""
                    ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES WHEN KMS KEY IS CREATED AND WHEN create_kms_keys_index_keys == the index key of the created KMS key -#

kms_key = flatten([ for Instance_Storage_Keys, Instance_Storage_Values in var.Instance_Storage: 
                      [ for config, config_values in Instance_Storage_Values.configurations: 
                          [ for kms_key_keys, kms_key_values in config_values.create_kms_keys: {
                                kms_key_name = kms_key_values.kms_key_name
                                key_usage = kms_key_values.key_usage
                                cstmr_mstr_key_spec = kms_key_values.cstmr_mstr_key_spec
                                is_enabled = kms_key_values.is_enabled
                                key_rotation_enabled = kms_key_values.key_rotation_enabled
                                policy_file = kms_key_values.policy_file != "" ? file(kms_key_values.policy_file) : ""
                                bypass_policy_lockout_safety_check = kms_key_values.bypass_policy_lockout_safety_check
                          }
                        ]
                    if Instance_Storage_Values.enabled_config_index_key == config 
                    ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET NETWORK INTERFACE ID WHEN TAG IS SPECIFED -#

eni_tag = flatten([ for Instance_Networking_Keys, Instance_Networking_Values in var.Instance_Networking: 
                      [ for config, config_values in Instance_Networking_Values.configurations: 
                          [ for eni_keys, eni_values in config_values.network_interfaces:  {
                          eni_tag = eni_values.get_eni_by_tag
                          eni_tag_key = element(keys( eni_values.get_eni_by_tag ), 0)
                    } ]
                    if Instance_Networking_Values.enabled_config_index_key == config && eni_values.get_eni_by_tag != {}
                    ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GATHERING GET/CREATE SECURITY GROUPS ##

  lt_get_sec_grp = flatten([ for Instance_Networking_Keys, Instance_Networking_Values in var.Instance_Networking:
                            [ for config, config_values in Instance_Networking_Values.configurations: 
                              [ for secgrp, secgrp_vals in config_values.get_create_security_groups: {
                              secgrp_key = secgrp
                              secgrp_value = secgrp_vals
                          } ] ] if Instance_Networking_Values.enabled_config_index_key == config && element(split("_", secgrp), 0 ) == "get" ]   )

  join_merge_lt_sec_grp = merge(join(", ", local.lt_get_sec_grp))

  lt_create_sec_grp = flatten([ for Instance_Networking_Keys, Instance_Networking_Values in var.Instance_Networking:
                                [ for config, config_values in Instance_Networking_Values.configurations: 
                                  [ for secgrp, secgrp_vals in config_values.get_create_security_groups:
                                    [ for rule_values in secgrp_vals: {
                                          secgrp_key = secgrp
                                          direction = element( split("|", rule_values) , 0 )
                                          type = element( split("|", rule_values) , 1 )
                                          type_value = element( split("|", rule_values) , 2 )
                                          protocol = element( split("|", rule_values) , 3 )
                                          from_port = element( split("|", rule_values) , 4 )
                                          to_port = element( split("|", rule_values) , 5 )
                                          rule_name = element( split("|", rule_values) , 6 )
                                      } ] ] ]
                                      if element(split("_", secgrp), 0 ) == "create"
                              ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET ASG SCALING and ASG PLACEMENT VALUES ##

# SCALING #
# Pulls values from the var.ASG_Scaling variable into a local variable (asg_scaling)

asg_scaling = flatten( [ for scale_keys, scaling_value in var.ASG_Scaling: {
                              #- Index Key -#
                              scaling_index_key = scale_keys
                              #- Scaling Base -#
                              min_size = scaling_value.min_size
                              max_size = scaling_value.max_size
                              desired_capacity = scaling_value.desired_capacity
                              capacity_rebalance = scaling_value.capacity_rebalance
                              protect_from_scale_in = scaling_value.protect_from_scale_in
                              enabled_metrics = scaling_value.enabled_metrics
                              metrics_granularity = scaling_value.metrics_granularity
                              default_cooldown = scaling_value.default_cooldown
                              wait_for_capacity_timeout = scaling_value.wait_for_capacity_timeout
                              health_check_type = each.value.scaling.health_check_type
                              health_check_grace_period = each.value.scaling.health_check_grace_period
                              #- Policy + Hook Attachments -#
                              asg_scaling_policies_config_index_keys = scaling_value.asg_scaling_policies_config_index_keys
                              asg_schedule_policies_config_index_keys = scaling_value.asg_schedule_policies_config_index_keys
                              asg_lifecycle_hook_config_index_keys = scaling_value.asg_lifecycle_hook_config_index_keys
                              asg_notifications_config_index_keys = scaling_value.asg_notifications_config_index_keys
                              #- On-Demand Instance Distribution -#
                              instances_distribution = {
                                on_demand_allocation_strategy = scaling_value.instances_distribution.on_demand_allocation_strategy
                                on_demand_base_capacity = scaling_value.instances_distribution.on_demand_base_capacity
                                on_demand_percentage_above_base_capacity = scaling_value.instances_distribution.on_demand_percentage_above_base_capacity
                                on_demand_max_price_percentage_over_lowest_price = scaling_value.instances_distribution.on_demand_max_price_percentage_over_lowest_price
                                #- Capcacity Reservations -#
                                capacity_reservations = scaling_value.instances_distribution.capacity_reservations
                              }
                              #- Spot Distribution -#
                              spot_distribution = {
                                spot_allocation_strategy = scaling_value.spot_distribution.spot_allocation_strategy
                                spot_instance_pools = scaling_value.spot_distribution.spot_instance_pools
                                spot_max_price = scaling_value.spot_distribution.spot_max_price
                                spot_max_price_percentage_over_lowest_price = scaling_value.spot_distribution.spot_max_price_percentage_over_lowest_price
                              }
                              #- Warm Pool Instances -#
                              warm_pool = {
                                pool_state = scaling_value.warm_pool.pool_state
                                min_size = scaling_value.warm_pool.min_size
                                reuse_on_scale_in = scaling_value.warm_pool.reuse_on_scale_in
                                max_group_prepared_capacity = scaling_value.warm_pool.max_group_prepared_capacity
                              }
                              #- Launch Template Overrides -#
                              launch_template_overrides = scaling_value.launch_template_overrides
                              #- Instance Refresh -#
                              instance_refresh = {
                                triggers = scaling_value.instance_refresh.triggers
                                strategy = scaling_value.instance_refresh.strategy
                                checkpoint_delay_preference = scaling_value.instance_refresh.checkpoint_delay_preference
                                checkpoint_percentages_preference = scaling_value.instance_refresh.checkpoint_percentages_preference
                                instance_warmup_preference = scaling_value.instance_refresh.instance_warmup_preference
                                min_health_percentage_preference = scaling_value.instance_refresh.min_health_percentage_preference
                              }
                              #- Instance Offline -#
                              instance_offline = {
                                max_instance_lifetime = scaling_value.instance_offline.max_instance_lifetime
                                suspended_processes = scaling_value.instance_offline.suspended_processes
                                termination_policies = scaling_value.instance_offline.termination_policies
                                force_delete = scaling_value.instance_offline.force_delete
                              } }
                              if scale_keys == placement_value.asg_scaling_config_index_key
                              ] )

asg_scaling_object = { for o in local.asg_scaling: o.scaling_index_key => o }

# PLACEMENT #
# Pulls values from the var.ASG_Placement variable into a local.variable
# Based on asg_scaling_config_index_key, Pulls in scaling values from local.asg_scaling variable and sets it as element for asg_scale_pbject in asg_placement local variable

asg_placement = flatten( [ for place_keys, place_values in var.ASG_Placement: [
                  for placement_key, placement_value in values.configurations: {
                    placement_index_key = "${var.asg_name}-${place_keys}"
                    vpc_zone_identifier = placement_value.vpc_zone_identifier
                    target_group_arns = placement_value.target_group_arns
                    min_elb_capacity = placement_value.min_elb_capacity
                    wait_for_elb_capacity = placement_value.wait_for_elb_capacity
                    placement_group = placement_value.placement_group
                    #- Classic Placement -#
                    availability_zone = placement_value.availability_zone
                    load_balancers = placement_value.load_balancers
                    #- Scaling Attachment -#
                    asg_scaling_config_index_key = placement_value.asg_scaling_config_index_key
                    asg_scale_object = element([ for key, value in asg_scaling_object: matchkeys( [value], [key], [placement_value.asg_scaling_config_index_key] )], 0)
                    #- Tags -#
                    asg_tags = placement_value.asg_tags
                  }
                  if contains(values.enabled_config_index_key, placement_key) == true
                  ]
              ] )

# Policy + Hook attachments #
# Creates an object of the asg_placement local variable to be used in policy + hook attachments below when doing a match keys function

asg_placement_object = { for o in local.asg_placement: o.placement_index_key => o }

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

# GET ASG SCALING OBJECT AND ATTACH IT TO ASG SCALING POLICY ##

scaling_policy_object = { for o in local.scaling_policies: o.policy_index_key => o }

scaling_policies = flatten( [ for policy_key, policy_values in var.ASG_policies: {
                                  policy_index_key = policies_key
                                  policy_name = policy_values.policy_name
                                  asg_scaling_config_index_keys = policy_values.asg_scaling_config_index_keys
                                  policy_type = policy_values.policy_type
                                  adjustment_type = policy_values.adjustment_type
                                  estimated_instance_warmup = policy_values.estimated_instance_warmup
                                  simple_scaling = policy_values.SimpleScaling
                                  StepScaling = policy_values.StepScaling
                                  target_tracking_scaling = policy_values.target_tracking_scaling
                                  predictive_scaling = policy_values.predictive_scaling
                                }
                           ] )

scaling_policy_attachment = flatten( [ for placement_key, placement_value in local.asg_placement_object: [
                                        for scaling_key, scaling_value in placement_value.asg_scale_object: [
                                          for scaling_attachment in scaling_value.asg_scaling_policies_config_index_keys: {
                                            asg_index_key = placement_key
                                            attachment_index_key = "${scaling_key}-${scaling_attachment}"
                                            scaling_index_key = scaling_key
                                            scaling_value = element( flatten([ for key, value in local.scaling_policy_object: matchkeys( [value], [key], [scaling_attachment] ) ]), 0 )
                                    } ] ] ] )

predictive_load_metric_custom_data_queries = flatten([ for policy, policy_values in var.ASG_Policies: [
                                                        for values, predictive_scaling_values in policy_values.PredictiveScaling: [
                                                          for load_metric_values, load_metric_types in predictive_scaling_values.load_metrics: [
                                                            for metric_data_query_key, metric_data_query_value in load_metric_values.custom: {
                                                                index_key = metric_data_query_key
                                                                id = metric_data_query.id
                                                                label = metric_data_query.label
                                                                return_data = metric_data_query.return_data
                                                                expression = lookup(metric_data_query, "expression", null)
                                                                metric_stat = lookup(metric_data_query, "metric_stat", null)
                                                                # metric_stat = {
                                                                #     metric_name = metric_data_query.
                                                                #     namespace = metric_data_query.
                                                                #     stat = metric_data_query.
                                                                #     unit = metric_data_query.
                                                                #     dimensions = { name = "", value = ""}
                                                                # }
                                                            }                                                   
                                                          ]
                                                        ]
                                                      ] if policy_values.policy_type == "PredicitiveScaling" ])

predictive_capacity_metric_custom_data_queries = flatten()

predictive_scaling_metric_custom_data_queries = flatten()

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET ASG SCALING OBJECT AND ATTACH IT TO ASG SCHEDULE POLICY ##

asg_schedule_object = { for o in local.asg_schedule: o.schedule_index_key => o }

asg_schedule = flatten( [ for schedule_key, schedule in var.ASG_Schedules: {
                            schedule_index_key = schedule_key
                            scheduled_action_name = schedule.scheduled_action_name
                            start_time = schedule.start_time
                            end_time = schedule.end_time
                            recurrence = schedule.recurrence
                            time_zone = schedule.time_zone
                            min_size = schedule.min_size
                            max_size = schedule.max_size
                            desired_capacity = schedule.desired_capacity
                      } ] )

schedule_policy_attachment = flatten( [ for placement_key, placement_value in local.asg_placement_object: [
                                          for scaling_key, scaling_value in var.ASG_Scaling: [
                                            for schedule_attachment in scaling_value.asg_schedule_policies_config_index_keys: {
                                              asg_index_key = placement_key
                                              attachment_index_key = "${scaling_key}-${schedule_attachment}"
                                              scaling_index_key = scaling_key
                                              scaling_value = element( flatten([ for key, value in local.schedule_policy_object: matchkeys( [value], [key], [schedule_attachment] ) ]), 0 )
                                            } ] ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GET ASG SCALING OBJECT AND ATTACH IT TO ASG LIFECYCLE HOOK ##

asg_lifescycle_hook = flatten( [ for hook_key, hook_value in var.ASG_Lifecycle_Hooks: {
                                  lifecycle_hook_index_key = hook_key
                                  lifecycle_hook_name = hook_value.lifecycle_hook_name
                                  default_result         = hook_value.default_result
                                  heartbeat_timeout      = hook_value.heartbeat_timeout
                                  lifecycle_transition   = hook_value.lifecycle_transition
                                  notification_target_arn = hook_value.notification_target_arn
                                  role_arn                = hook_value.role_arn
                                  notification_metadata = hook_value.notification_metadata
                              } ] )

asg_lifecycle_hook_object = { for o in local.asg_lifecycle_hook: o.lifecycle_hook_index_key => o }

lifescycle_hook_attachment = flatten( [ for placement_key, placement_value in local.asg_placement_object: [
                                          for scaling_key, scaling_value in var.ASG_Scaling: [
                                            for lifecycle_hook_attachment in scaling_value.asg_lifecycle_hook_config_index_keys: {
                                              asg_index_key = placement_key
                                              attachment_index_key = "${scaling_key}-${lifecycle_hook_attachment}"
                                              scaling_index_key = scaling_key
                                              scaling_value = element( flatten([ for key, value in local.lifecycle_hook_object: matchkeys( [value], [key], [lifecycle_hook_attachment] ) ]), 0 )
                                        } ] ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

asg_notification = flatten( [ for notification_key, notification_value in var.ASG_Notifications: {
                                notification_index_key = notification_key
                                notifications = notification_value.notifications
                                sns_topic_name = notification_value.sns_topic_name
                            } ] )

asg_notification_object = { for o in local.asg_notification: o.notification_index_key => o }

notification_attachment = flatten( [ for placement_key, placement_value in local.asg_placement_object: [
                                      for scaling_key, scaling_value in var.ASG_Scaling: [
                                        for notification_attachment in scaling_value.asg_notification_config_index_keys: {
                                          asg_index_key = placement_key
                                          attachment_index_key = "${scaling_key}-${notification_attachment}"
                                          scaling_index_key = scaling_key
                                          scaling_value = element( flatten([ for key, value in local.lifecycle_hook_object: matchkeys( [value], [key], [notification_attachment] ) ]), 0 )
                                    } ] ] ] )

}

######################################################################################################################################################

#############
## Get AMI ##
#############
resource "aws_ami_copy" "copy_ami" {
for_each = { for o in local.copy_ami: o.new_ami_name => o }

  name              = each.value.new_ami_name
  description       = each.value.description
  source_ami_id     = each.value.source_ami_id
  source_ami_region = each.value.source_ami_region
  destination_outpost_arn = each.value.destination_outpost_arn 
  encrypted = each.value.encrypted
  kms_key_id = each.value.kms_key_id
  tags = each.value.copy_ami_tags
}

############################
## Copy from Instance AMI ##
############################

resource "aws_ami_from_instance" "copy_from_instance_ami" {
for_each = { for o in local.copy_ami_instance: o.new_ami_name => o }

  name               = each.value.new_ami_instance
  source_instance_id = each.value.source_instance_id
  snapshot_without_reboot = each.value.snapshot_without_reboot
  tags = each.value.copy_ami_instance_tags
}

#########################################################
## Create New IAM Instance Profile for Launch Template ##
#########################################################

resource "aws_iam_instance_profile" "instance_profile" {
for_each = { for o in local.iam_instance_profile: o.instance_profile_name => o }
  name = each.value.instance_profile_name
  role = aws_iam_role.instance_profile_role[each.value.instance_profile_name].name
}

resource "aws_iam_role" "instance_profile_role" {
for_each = { for o in local.iam_instance_profile: o.instance_profile_name => o }
  name = each.value.instance_profile_name
  path = each.value.path

  assume_role_policy = file(each.value.policy_file)
}

##########################################
## New SSH Key Pair for Launch Template ##
##########################################

resource "aws_key_pair" "lt_key_pair" {
for_each = { for o in local.key_pair: o.new_key_pair_name => o }
  key_name   = each.value.new_key_pair_name
  public_key = file(each.value.public_key_file)
}

#####################
## Create KMS Keys ##
#####################
resource "aws_kms_key" "lt_create_kms_key" {
for_each = { for o in local.kms_key: o.kms_key_name => o }

  kms_key_name = each.value.kms_key_name
  key_usage = each.value.key_usage
  cstmr_mstr_key_spec = each.value.cstmr_mstr_key_spec
  is_enabled = each.value.is_enabled
  key_rotation_enabled = each.value.key_rotation_enabled
  policy_file = file(each.value.policy_file)
  bypass_policy_lockout_safety_check = each.value.bypass_policy_lockout_safety_check

  tags = {
    Name = each.value.kms_key_name
  }
}

#####################################
## Get Network Interface ID by Tag ##
#####################################
data "aws_network_interfaces" "get_eni_id_tag" {
for_each = { for o in local.eni_tag: o.eni_tag_key => o }

  tags = each.value.eni_tag
}

##################################
## Get Security Group ID by Tag ##
##################################

data "aws_security_group" "lt_get_security_group" {
for_each = { for o in local.join_merge_lt_sec_grp: o.secgrp_key => o }

  tags = each.value.secgrp_value
}

###########################
## Create Security Group ##
###########################

resource "aws_security_group" "lt_create_security_group" {
for_each = { for o in local.lt_create_sec_grp: o.secgrp_key => o }

  vpc_id = var.vpc_id

  dynamic "ingress" {
  for_each = { for o in local.lt_create_sec_grp: o.rule_name => o if o.direction == "Ingress"}
  content {
      cidr_blocks = ingress.value.type == "IPv4" ? [ingress.value.type_value] : []
      ipv6_cidr_blocks = ingress.value.type == "IPv6" ? [ingress.value.type_value] : []
      security_groups = ingress.value.type == "Security_Groups" ? [ingress.value.type_value] : []
      prefix_list_ids = ingress.value.type == "Prefix_List_IDs" ? [ingress.value.type_value] : []
      protocol  = ingress.value.protocol
      from_port = ingress.value.from_port
      to_port   = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = { for o in local.default_security_group: o.rule_name => o if o.direction == "Egress"}
    content {
        cidr_blocks = egress.value.type == "IPv4" ? [egress.value.type_value] : []
        ipv6_cidr_blocks = egress.value.type == "IPv6" ? [egress.value.type_value] : []
        security_groups = egress.value.type == "Security_Groups" ? [egress.value.type_value] : []
        prefix_list_ids = egress.value.type == "Prefix_List_IDs" ? [egress.value.type_value] : []
        protocol  = egress.value.protocol
        from_port = egress.value.from_port
        to_port   = egress.value.to_port
      }
    }

  tags = merge(
    {
      "Name" = each.value.default_security_group.security_group_name
    },
  )
}

###########################
## Capacity Reservations ##
###########################

resource "aws_ec2_capacity_reservation" "capacity_reservations" {

  #- Instance -#
  instance_match_criteria = "" # open | targeted
  instance_type     = "t2.micro"
  instance_platform = "Linux/UNIX"
  instance_count    = 1
  #- Storage -#
  ebs_optimized = false
  ephemeral_storage = ""
  #- Placement -#
  availability_zone = "eu-west-1a"
  outpost_arn = ""
  #- End Date -#
  end_date = "" # YYYY-MM-DDTHH:MM:SSZ
  #- tags -#
  tags = {}
  
}

######################################################################################################################################################

##########################################
#- Launch Template State ----------------#
##########################################

resource "aws_launch_template" "new_ec2_launch_template" {
for_each = local.launch_template
  
  name = var.launch_template_name
  name_prefix = var.launch_template_name_prefix
  description = var.description
  default_version = var.default_version
  update_default_version = var.update_default_version

  ###################
  #- Instance Boot -#
  ###################
  #- AMI -#
  image_id = each.value.Instance_Boot.get_ami_type == "ami_id" ? each.value.Instance_Boot.get_ami_values.ami_id : each.value.Instance_Boot.get_ami_type == "copy_ami" ? aws_ami_copy.copy_ami[each.value.Instance_Boot.get_ami_values.new_ami_name].id : each.value.Instance_Boot.get_ami_type == "copy_ami_instance" ? aws_ami_from_instance.copy_from_instance_ami[each.value.Instance_Boot.get_ami_values.new_ami_name].id : null

  #- Licensing -#
  dynamic "license_specification" {
  for_each = each.value.Instance_Boot.license_configuration_arn == "" ? {} : local.launch_template
    license_configuration_arn = license_specification.value.license_configuration_arn
  }

  #- User Data -#
  user_data = each.value.Instance_Boot.user_data.file == "" ? "" : templatefile(each.value.Instance_Boot.user_data.file, each.value.Instance_Boot.user_data.env_vars )
  metadata_options {
    http_endpoint = each.value.Instance_Boot.metadata_options.http_endpoint # enabled | disabled 
    http_tokens = each.value.Instance_Boot.metadata_options.http_tokens # optional | required
    http_put_response_hop_limit = each.value.Instance_Boot.metadata_options.http_put_response_hop_limit
    htttp_protocol_ipv6 = each.value.Instance_Boot.metadata_options.htttp_protocol_ipv6 # enabled | disabled
    instance_metadata_tags = each.value.Instance_Boot.metadata_options.instance_metadata_tags # enabled | disabled
  }

  #- Access -#
  iam_instance_profile {
    arn = each.value.Instance_Boot.iam_instance_profile.instance_profile_name != "" ? aws_iam_instance_profile.instance_profile[each.value.Instance_Boot.iam_instance_profile.instance_profile_name].arn : each.value.Instance_Boot.iam_instance_profile.arn
  }
  key_name = each.value.Instance_Boot.ssh_key_pair.public_key_file != "" ? aws_key_pair.lt_key_pair[each.value.Instance_Boot.ssh_key_pair.new_key_pair_name].name : each.value.Instance_Boot.ssh_key_pair.existing_key_pair_name

  #- Monitoring -#
  monitoring {
    enabled = each.value.Instance_Boot.enable_detailed_instance_monitoring
  }

  ####################
  #- Instance Types -#
  ####################
  instance_type = each.value.Instance_Types.instance_type

  ## Other Instance Type specs are located within the Instance Requirements section below ##

  ######################
  #- CPU Per Instance -#
  ######################
  cpu_options {
    core_count = each.value.Instance_CPU.cpu_count
    threads_per_core = each.value.Instance_CPU.cpu_credits
  }
  credit_specification {
    cpu_credits = each.value.Instance_CPU.cpu_credits # standard | unlimited
  }
  elastic_inference_accelerator {
    type = each.value.Instance_CPU.elastic_inference_accelerator_type
  }
  enclave_options {
    enabled = each.value.Instance_CPU.enable_nitro_enclaves
  }

  ## Other Instance CPU specs are located within the Instance Requirements section below ##

  #########################
  #- Memory Per Instance -#
  #########################
  kernel_id = each.value.Instance_Memory.kernel_id
  ram_disk_id = each.value.Instance_Memory.ram_disk_id

   ## Instance Memory specs are located within the Instance Requirements section below ##

  ######################
  #- GPU Per Instance -#
  ######################
  elastic_gpu_specifications {
      type = each.value.Instance_GPU.gpu_type
  }
  ########################################
  #- Instance Accelerators Per Instance -#
  ########################################

  ## Instance Accelerator specs are located within the Instance Requirements section below ##

  ######################
  #- Instance Storage -#
  ######################
  ebs_optimized = each.value.Instance_Storage.ebs_optimized
  dynamic "block_device_mappings" {
  for_each = each.value.Instance_Storage.ebs_blocks
  content {
    device_name = block_device_mappings.value.device_name
    no_device = block_device_mappings.value.no_device
    virtual_name = block_device_mappings.value.virtual_name
    ebs {
        delete_on_termination = block_device_mappings.value.ebs.delete_on_termination
        encrypted = block_device_mappings.value.ebs.encrypted # if snapshot_id != "" then conflict
        kms_key_id = block_device_mappings.value.ebs.create_kms_keys_index_keys != "" ? aws_kms_key.lt_create_kms_key[block_device_mappings.value.ebs.kms_key_name].id : block_device_mappings.value.ebs.kms_key_id
        volume_type = block_device_mappings.value.ebs.volume_type
        iops = block_device_mappings.value.ebs.iops
        throughput = block_device_mappings.value.ebs.throughput
        volume_size = block_device_mappings.value.ebs.volume_size
        snapshot_id = block_device_mappings.value.ebs.snapshot_id
      }
    }
  }
  
## Other Instance Storage specs are located within the Instance Requirements section below ##

  #########################
  #- Instance Networking -#
  #########################
  dynamic "network_interfaces" {
  for_each = each.value.Instance_Networking.network_interfaces
  content {
    #- Existing ENI -#
    network_interface_id = network_interfaces.value.get_eni_by_tag != {} ? element(data.aws_network_interfaces.get_eni_id_tag[element( keys(network_interface.value.get_eni_by_tag) , 0 )].ids, 0 ) : network_interfaces.value.get_eni_by_id != "" ? network_interfaces.value.get_eni_by_id : null
    #- Create ENI -#
    associate_carrier_ip_address = network_interfaces.value.associate_carrier_ip_address
    associate_public_ip_address = network_interfaces.value.associate_public_ip_address
    delete_on_termination = network_interfaces.value.delete_on_termination
    description = network_interfaces.value.description
    device_index = network_interfaces.value.device_index
    network_card_index = network_interfaces.value.network_card_index
    interface_type = network_interfaces.value.interface_type
    ipv4_address_count = network_interfaces.value.ipv4.ipv4_address_type == "[count]" ? element(network_interfaces.value.ipv4.ipv4_address_value, 0 ) : null
    ipv4_addresses = network_interfaces.value.ipv4.ipv4_address_type == "[list]" ? network_interfaces.value.ipv4.ipv4_address_value : null
    private_ip_address = network_interfaces.value.ipv4.ipv4_address_type == "[list]" ? element(network_interfaces.value.ipv4.ipv4_address_value, 0 ) : null
    ipv4_prefix_count = network_interfaces.value.ipv4.ipv4_prefix_type == "[count]" ? element(network_interfaces.value.ipv4.ipv4_prefix_value, 0 ) : null
    ipv4_prefixes = network_interfaces.value.ipv4.ipv4_prefix_type == "[list]" ? network_interfaces.value.ipv4.ipv4_prefix_value : null
    ipv6_address_count = network_interfaces.value.ipv6.ipv6_address_type == "[count]" ? element(network_interfaces.value.ipv6.ipv6_address_value, 0 ) : null
    ipv6_addresses = network_interfaces.value.ipv6.ipv6_address_type == "[list]" ? network_interfaces.value.ipv6.ipv6_address_value : null
    ipv6_prefix_count = network_interfaces.value.ipv6.ipv6_prefix_type == "[count]" ? element(network_interfaces.value.ipv6.ipv6_prefix_value, 0 ) : null
    ipv6_prefixes = network_interfaces.value.ipv6.ipv6_prefix_type == "[list]" ? network_interfaces.value.ipv6.ipv6_prefix_value : null
    #- Placement -#
    subnet_id = network_interfaces.value.subnet_id
    #- Traffic -#
    security_groups = flatten( [ [ for o in network_interfaces.value.security_group_index_keys: data.aws_security_group.lt_get_security_group[o].id if element(split("_", o ), 0 ) == "get" ] , [ for o in network_interfaces.value.security_group_index_keys: aws_security_group.lt_create_security_group[o].id if element(split("_", o ), 0 ) == "create" ] ] )
    #-Tags -#
    tags = {
      Name = network_interfaces.value.name
    }
  } 
  }

  vpc_security_group_ids = flatten( [ [ for o in each.value: data.aws_security_group.lt_get_security_group[o].id if element(split("_", o ), 0 ) == "get" ] , [ for o in network_interfaces.value.security_group_index_keys: aws_security_group.lt_create_security_group[o].id if element(split("_", o ), 0 ) == "create" ] ] )
  private_dns_name_options {
    enable_resource_name_dns_aaaa_record = each.value.Instance_Networking.private_dns_name_options.enable_resource_name_dns_aaaa_record
    enable_resource_name_dns_a_record = each.value.Instance_Networking.private_dns_name_options.enable_resource_name_dns_a_record
    hostname_type = each.value.Instance_Networking.private_dns_name_options.hostname_type
  }

  ##########################################
  #- Instance Requirements ----------------#
  ##########################################
  instance_requirements = {

  ###################
  #- Instance Boot -#
  ###################

  ## No Instance Boot requirements are to be specified ##

  ####################
  #- Instance Types -#
  ####################
  instance_generations = each.value.Instance_Types.instance_type_requirements.instance_generations
  excluded_instance_types = each.value.Instance_Types.instance_type_requirements.excluded_instance_types
  bare_metal = each.value.Instance_Types.instance_type_requirements.bare_metal_instances

  ######################
  #- CPU Per Instance -#
  ######################
  cpu_manufacturers = each.value.Instance_CPU.cpu_type_requirements.cpu_manufacturers
  vcpu_count = {
        min = each.value.Instance_CPU.instance_cpu_requirements.vcpu_count.min
        max = each.value.Instance_CPU.instance_cpu_requirements.vcpu_count.max
  }
  burstable_performance = each.value.Instance_CPU.cpu_type_requirements.burstable_performance

  #########################
  #- Memory Per Instance -#
  #########################
  memory_mib = {
        min = each.value.Instance_Memory.instance_memory_requirements.memory_mib.min
        max = each.value.Instance_Memory.instance_memory_requirements.memory_mib.max
  }
  memory_gib_per_vcpu = {
        min = each.value.Instance_Memory.instance_memory_requirements.memory_gib_per_vcpu.min
        max = each.value.Instance_Memory.instance_memory_requirements.memory_gib_per_vcpu.max
  }

  ######################
  #- GPU Per Instance -#
  ######################

  ## No Instance GPU requirements are to be specified ##

  ########################################
  #- Instance Accelerators Per Instance -#
  ########################################
  accelerator_manufacturers = each.value.Instance_Accelerators.instance_accelerator_requrirements.accelerator_manufacturers
  accelerator_names = each.value.Instance_Accelerators.instance_accelerator_requrirements.accelerator_names
  accelerator_types = each.value.Instance_Accelerators.instance_accelerator_requrirements.accelerator_types
  accelerator_count = { 
        min = accelerator_typeeach.value.Instance_Accelerators.instance_accelerator_requrirements.accelerator_count.min
        max = accelerator_typeeach.value.Instance_Accelerators.instance_accelerator_requrirements.accelerator_count.max
  }
  accelerator_total_memory_mib = {
          min = accelerator_typeeach.value.Instance_Accelerators.instance_accelerator_requrirements.accelerator_total_memory_mib.min
          max = accelerator_typeeach.value.Instance_Accelerators.instance_accelerator_requrirements.accelerator_total_memory_mib.max
  }  

  ######################
  #- Instance Storage -#
  ######################
  local_storage = each.value.Instance_Storage.instance_storage_requirements.local_storage
  local_storage_types = each.value.Instance_Storage.instance_storage_requirements.local_storage_types
  total_local_storage_gb = {
        min = each.value.Instance_Storage.instance_storage_requirements.total_local_storage_gb.min
        max = each.value.Instance_Storage.instance_storage_requirements.total_local_storage_gb.max
  }  
  baseline_ebs_bandwidth_mbps = {
        min = each.value.Instance_Storage.instance_storage_requirements.baseline_ebs_bandwidth_mbps.min
        max = each.value.Instance_Storage.instance_storage_requirements.baseline_ebs_bandwidth_mbps.max
  }

  #########################
  #- Instance Networking -#
  #########################
  network_interface_count = {
        min = each.value.Instance_Networking.instance_networking_requirements.network_interface_count.min
        max = each.value.Instance_Networking.instance_networking_requirements.network_interface_count.max
  }

  ######################
  #- Instance Offline -#
  ######################
  require_hibernate_support = each.value.Instance_Offline.instance_offline_requirement.hibernation_option_enabled
      
  }

  ######################################
  #- Instance Offline -----------------#
  ######################################
  maintenance_options = {
    auto_recovery = each.value.Instance_Offline.auto_recovery_enabled
  }
  disable_api_termination = each.value.Instance_Offline.disable_api_termination
  instance_initiated_shutdown_behavior = each.value.Instance_Offline.instance_initiated_shutdown_behavior
  
  
  

  ##########################################
  #- Capacity & Auto Scaling --------------#
  ##########################################
  placement {
    affinity = ""
    availability_zone = ""
    group_name = ""
    host_id = "" 
    host_resource_group_arn = ""
    spread_domain = ""
    tenancy = "" # default | dedicated | host
    partition_number = 0
  }
  capacity_reservation_specification {
    capacity_reservation_preference = "" # open | none
    capacity_reservation_target {
      capacity_reservation_id = ""
      capacity_reservation_resource_group_arn = ""
    }
  }
  instance_market_options {
    market_type = "" # spot
    spot_options {
      block_duration_minutes = 0
      instance_interruption_behavior = "" # hibernate | stop | terminate
      max_price = ""
      spot_instance_type = "" # one-time | persistent
      valid_until = ""
    }
  }
  


  ##########################################
  #- Launch Template Tags -----------------#
  ##########################################
  tag_specifications {
    
  }
  tags = {}
}

################################################################################

##########################################
## Launch Template: Auto Scaling Groups ##
##########################################

resource "aws_autoscaling_group" "lt_auto_scaling_group" {
for_each = local.asg_placement_object
  name = var.asg_name
  name_prefix = var.asg_prefix
  service_linked_role_arn = var.asg_service_linked_role

  #- PLacement -#
  vpc_zone_identifier = each.value.placement.vpc_zone_identifier
  target_group_arns = each.value.placement.target_group_arns
  min_elb_capacity = each.value.placement.min_elb_capacity
  wait_for_elb_capacity = each.value.placement.wait_for_elb_capacity
  placement_group = each.value.placement.placement_group
  #- Classic Placement -#
  availability_zones = each.value.placement.availability_zones
  load_balancers = each.value.placement.load_balancers
  #- Scaling -#
  min_size = each.value.asg_scale_object.min_size
  max_size = each.value.asg_scale_object.max_size
  desired_capacity = each.value.asg_scale_object.desired_capacity
  capacity_rebalance = each.value.asg_scale_object.capacity_rebalance
  protect_from_scale_in = each.value.asg_scale_object.protect_from_scale_in
  enabled_metrics = each.value.asg_scale_object.enabled_metrics
  metrics_granularity = each.value.asg_scale_object.metrics_granularity
  default_cooldown = each.value.asg_scale_object.default_cooldown
  wait_for_capacity_timeout = each.value.asg_scale_object.wait_for_capacity_timeout
  health_check_type = each.value.asg_scale_object.health_check_type
  health_check_grace_period = each.value.asg_scale_object.health_check_grace_period
  mixed_instances_policy {
    instances_distribution {
      #- On-Demand Instance Distribution -#
        on_demand_allocation_strategy = each.value.asg_scale_object.on_demand_distribution.on_demand_allocation_strategy
        on_demand_base_capacity = each.value.asg_scale_object.on_demand_distribution.on_demand_base_capacity
        on_demand_percentage_above_base_capacity = each.value.asg_scale_object.on_demand_distribution.on_demand_percentage_above_base_capacity
      #- Spot Distribution -#
        spot_allocation_strategy = each.value.asg_scale_object.spot_distribution.spot_allocation_strategy
        spot_instance_pools = each.value.asg_scale_object.spot_distribution.spot_instance_pools
        spot_max_price = each.value.asg_scale_object.spot_distribution.spot_max_price
    }
    launch_template {
        launch_template_specification {
            launch_template_id = ""
            launch_template_name = ""
            version = ""
        }
        dynamic "override" {
        for_each = each.value.asg_scale_object.launch_template_overrides
        content {
            weighted_capacity = override.value.weigted_capacity
            instance_type = override.value.instance_type
            launch_template_specification {
                  launch_template_id = override.value.launch_template.id
                  launch_template_name = override.value.launch_template.name
                  version = override.value.launch_template.version
            }
            instance_requirements {
                  #- Instances -#
                  instance_generations = lookup(override.value.instance_requirements, "instance_generations", [] )
                  excluded_instance_types = lookup(override.value.instance_requirements, "excluded_instance_types", [] )
                  on_demand_max_price_percentage_over_lowest_price = lookup(override.value.instance_requirements, "on_demand_max_price_percentage_over_lowest_price", null )
                  spot_max_price_percentage_over_lowest_price = lookup(override.value.instance_requirements, "spot_max_price_percentage_over_lowest_price", null )
                  bare_metal = lookup(override.value.instance_requirements, "bare_metal", null )
                  require_hibernate_support = lookup(override.value.instance_requirements, "require_hibernate_support", false )
                  #- CPU -#
                  cpu_manufacturers = lookup(override.value.instance_requirements, "cpu_manufacturers", [] )
                  vcpu_count { 
                    min = lookup(override.value.instance_requirements.vcpu_count, "min", null )
                    max = lookup(override.value.instance_requirements.vcpu_count, "max", null )
                  }
                  burstable_performance = lookup(override.value.instance_requirements, "burstable_performance", null )
                  #- Accelerators -#
                  accelerator_types = lookup(override.value.instance_requirements, "accelerator_types", null )
                  accelerator_manufacturers = lookup(override.value.instance_requirements, "accelerator_manufacturers", null )
                  accelerator_names = lookup(override.value.instance_requirements, "accelerator_names", null )
                  accelerator_count {
                    min = lookup(override.value.instance_requirements.accelerator_count, "min", null )
                    max = lookup(override.value.instance_requirements.accelerator_count, "max", null )
                  }
                  accelerator_total_memory_mib {
                    min = lookup(override.value.instance_requirements.accelerator_total_memory_mib, "min", null )
                    max = lookup(override.value.instance_requirements.accelerator_total_memory_mib, "max", null )
                  }
                  #- Memory -#
                  memory_gib_per_vcpu {
                    min = lookup(override.value.instance_requirements.memory_gib_per_vcpu, "min", null )
                    max = lookup(override.value.instance_requirements.memory_gib_per_vcpu, "max", null )
                  }
                  memory_mib {
                    min = lookup(override.value.instance_requirements.memory_mib, "min", null )
                    max = lookup(override.value.instance_requirements.memory_mib, "max", null )
                  }
                  #- Storage -#
                  local_storage = ""
                  total_local_storage_gb {
                    min = lookup(override.value.instance_requirements.total_local_storage_gb, "min", null )
                    max = lookup(override.value.instance_requirements.total_local_storage_gb, "max", null )
                  }
                  baseline_ebs_bandwidth_mbps {
                    min = lookup(override.value.instance_requirements.baseline_ebs_bandwidth_mbps, "min", null )
                    max = lookup(override.value.instance_requirements.baseline_ebs_bandwidth_mbps, "max", null )
                  }
                  #- Network -#
                  network_interface_count {
                    min = lookup(override.value.instance_requirements.network_interface_count, "min", null )
                    max = lookup(override.value.instance_requirements.network_interface_count, "max", null )
                  }     
            }    
          }
        }
      }
  }

warm_pool {
    pool_state = each.value.asg_scale_object.warm_pool.pool_state
    min_size = each.value.asg_scale_object.warm_pool.min_size
    instance_reuse_policy { reuse_on_scale_in = each.value.asg_scale_object.warm_pool.reuse_on_scale_in }
    max_group_prepared_capacity = each.value.asg_scale_object.warm_pool.max_group_prepared_capacity
  }

  instance_refresh {
    triggers = each.value.asg_scale_object.instance_refresh.triggers
    strategy = each.value.asg_scale_object.instance_refresh.strategy
    preferences {
        checkpoint_delay = each.value.asg_scale_object.instance_refresh.checkpoint_delay
        checkpoint_percentages = each.value.asg_scale_object.instance_refresh.checkpoint_percentages
        instance_warmup = each.value.asg_scale_object.instance_refresh.instance_warmup
        min_health_percentage = each.value.asg_scale_object.instance_refresh.min_health_percentage
    } 
  }

  max_instance_lifetime = each.value.asg_scale_object.instance_offline.max_instance_lifetime
  suspended_processes = each.value.asg_scale_object.instance_offline.suspended_processes
  termination_policies = each.value.asg_scale_object.instance_offline.termination_policies
  force_delete = each.value.asg_scale_object.instance_offline.force_delete

  #-ASG Tags -#
  tags = each.value.ASG_Placement.asg_tags

}

################################################
## Launch Template: Auto Scaling Group Policy ##
################################################
resource "aws_autoscaling_policy" "lt_auto_scaling_group_policy" {
for_each = { for o in local.scaling_policy_attachment: o.attachment_index_key => o }
  enabled = true
  name = each.value.scaling_value.policy_name
  autoscaling_group_name = aws_autoscaling_group.lt_auto_scaling_group[each.value.index_key].name
  adjustment_type = each.value.scaling_value.adjustment_type
  policy_type = each.value.scaling_value.policy_type
  estimated_instance_warmup = each.value.scaling_value.estimated_instance_warmup
  #- Only Applies to "SimpleScaling" and "StepScaling" -#
  min_adjustment_magnitude = each.value.scaling_value.policy_type == "SimpleScaling" ? lookup(each.value.scaling_value.SimpleScaling.values, "min_adjustment_magnitude", null) : each.value.scaling_value.policy_type == "StepScaling" ? lookup(each.value.scaling_value.StepScaling.values, "min_adjustment_magnitude", null) : null
  #- Only Applies to "SimpleScaling" -#
  cooldown = each.value.scaling_value.policy_type == "SimpleScaling" ? lookup(each.value.scaling_value.SimpleScaling.values, "cooldown", null) : null
  scaling_adjustment = each.value.scaling_value.policy_type == "SimpleScaling" ? lookup(each.value.scaling_value.SimpleScaling.values, "scaling_adjustment", null) : null

  #- Only Applies to "StepScaling" -#
  metric_aggregation_type = each.value.scaling_value.policy_type == "StepScaling" ? lookup(each.value.scaling_value.StepScaling.values, "metric_aggregation_type", null) : null
  dynmamic "step_adjustment" {
  for_each = each.value.scaling_value.policy_type != "StepScaling" ? {} : each.value.scaling_value.StepScaling
  content {
    scaling_adjustment = step_adjustment.value.step_adjustment.scaling_adjustment
    metric_interval_lower_inbound = step_adjustment.value.step_adjustment.metric_interval_lower_inbound
    metric_interval_upper_bound = step_adjustment.value.step_adjustment.metric_interval_upper_bound
  } 
  }

  #- Only Applies to "TargetTrackingScaling" -#
  dynamic "target_tracking_configuration" {
  for_each = each.value.scaling_value.policy_type != "TargetTrackingScaling" ? {} : each.value.scaling_value.TargetTrackingScaling
  content {
    dynamic "predifined_metric_specification" { # Conflicts with customize_metric_specification
    for_each = target_tracking_configuration.value.target_tracking_type == "predifined" ? toset([ for t, k in target_tracking_configuration.value.target_tracking_values: k if t == "predifined" ]) : []
    #for_each = lookup(each.value.scaling_policies.TargetTrackingScaling.values.
    content {
        predifined_metric_type = predifined_metric_specification.value.predifined_metric_type
        resource_label = predifined_metric_specification.value.resource_label
      }
    } 
    dynamic "customized_metric_specification" { # Conflicts with predifined_metric_specification
    for_each = target_tracking_configuration.value.target_tracking_type == "custom" ? toset([ for t, k in target_tracking_configuration.value.target_tracking_values: k if t == "custom" ]) : []
    content {
        metric_name = customized_metric_specification.value.metric_name
        metric_dimension {
          name = customized_metric_specification.value.metric_dimension.name
          value = customized_metric_specification.value.metric_dimension.value
        }
        statistic = customized_metric_specification.value.statistic
        unit = customized_metric_specification.value.unit
        namespace = customized_metric_specification.value.namespace
    } }
    target_value = target_tracking_configuration.value.target_value
    disable_scale_in = target_tracking_configuration.value.disable_scale_in
    } 
    }

  dynamic "predictive_scaling_configuration" {
  for_each = each.value.scaling_value.policy_type != "PredictiveScaling" ? {} : each.value.scaling_value.PredictiveScaling 
  content {
    max_capacity_breach_behavior = predictive_scaling_configuration.value.max_capacity_breach_behavior
    max_capacity_buffer = predictive_scaling_configuration.value.max_capacity_buffer
    mode = predictive_scaling_configuration.value.mode
    scheduling_buffer_time = predictive_scaling_configuration.value.scheduling_buffer_time
    target_value = predictive_scaling_configuration.value.target_value

    metric_specification {
      dynamic "predefined_load_metric_specification" {
      for_each = lookup(predictive_scaling_configuration.value, "load_metrics", {} ) != {} toset([ for t, k in predictive_scaling_configuration.value.load_metrics.values: k if t == "predifined" ]) : []
      content {
          predefined_metric_type = predefined_load_metric_specification.value.predefined_metric_type
          resource_label = predefined_load_metric_specification.value.resource_label
        }
      }
      dynamic "customized_load_metric_specification" {
      for_each = lookup(predictive_scaling_configuration.value, "load_metrics", {} ) != {} ? { for o in local.predictive_load_metric_custom_data_queries: o.index_key => o } : {}                                                                                                      
      content {
        metric_data_queries = {
          id = each.value.id
          label = each.value.label
          return_data = each.value.return_data
          expression = each.value.expression
          metric_stat = {
              stat = lookup(each.value.metric_stat, "")
              unit = 0
              metric = {
                metric_name = ""
                namespace = ""
                dimensions = {
                  name = ""
                  value = ""
                }
              }
          }
        }
      }
      }







                              # module_structure 
                              # {
                              #   # Expression | metric_stat
                              #   # Not Both
                              #   id = ""
                              #   label = ""
                              #   return_data = false
                              #   expression = ""
                              #   metric_stat {
                              #     stat = ""
                              #     unit = 0
                              #     metric = {
                              #       metric_name = ""
                              #       namespace = ""
                              #       dimensions = {
                              #         name = ""
                              #         value = ""
                              #       }
                              #     }
                              #   }
                              # }
        }
      }
        predefined_scaling_metric_specification {
            predefined_metric_type = "" # ASGAverageCPUUtilization | ASGAverageNetworkIN | ASGAverageNetworkOut | ALBRequestCountPerTarget
            resource_label = ""
        }
        customized_capacity_metric_specification { # Only valid when customized_load_metric_specification is used
            metric_data_queries = flatten([ for o, k in var.lt_asg_policies: [
                                              for v, m in k.predictive_scaling_configuration: m.metric_specification  
                                          ] ] )
                                  # module_structure 
                                  # {
                                  #   # Expression | metric_stat
                                  #   # Not Both
                                  #   id = ""
                                  #   label = ""
                                  #   return_data = false
                                  #   expression = ""
                                  #   metric_stat {
                                  #     stat = ""
                                  #     unit = 0
                                  #     metric = {
                                  #       metric_name = ""
                                  #       namespace = ""
                                  #       dimensions = {
                                  #         name = ""
                                  #         value = ""
                                  #       }
                                  #     }
                                  #   }
                                  # }
          }
        }
         predefined_metric_pair_specification {
            predefined_metric_type = "" # ASGCPUUtilization | ASGNetworkIn | ASDNetworkOut | ALBRequestCount
            resource_label = ""
        }
        customized_scaling_metric_specification {
            metric_data_queries = flatten([ for o, k in var.lt_asg_policies: [
                                              for v, m in k.predictive_scaling_configuration: m.metric_specification  
                                          ] ] )
                                  # module_structure 
                                  # {
                                  #   # Expression | metric_stat
                                  #   # Not Both
                                  #   id = ""
                                  #   label = ""
                                  #   return_data = false
                                  #   expression = ""
                                  #   metric_stat {
                                  #     stat = ""
                                  #     unit = 0
                                  #     metric = {
                                  #       metric_name = ""
                                  #       namespace = ""
                                  #       dimensions = {
                                  #         name = ""
                                  #         value = ""
                                  #       }
                                  #     }
                                  #   }
                                  # }
        }
        
       
        
    }
  }
}

###########################################################
## Launch Template: Auto Scaling Group Scheduling Policy ##
###########################################################
resource "aws_autoscaling_schedule" "lt_asg_scheduling_policy" {
  autoscaling_group_name = ""
  scheduled_action_name = ""
  start_time = "" # Format: YYYY-MM-DDThh:mm:ssZ
  end_time = "" # Format: YYYY-MM-DDThh:mm:ssZ
  recurrence = "" # Time when recurring future actions will start. Unix cron syntax format only
  time_zone = "" # Tzone for cron express. C-names from IANA Tzones only
  min_size = 0
  max_size = 0
  desired_capacity = 0
}

########################################################
## Launch Template: Auto Scaling Group Lifecycle Hook ##
########################################################
resource "aws_autoscaling_lifecycle_hook" "lt_asg_lifecycle_hook" {
  name                   = "foobar"
  autoscaling_group_name = aws_autoscaling_group.foobar.name
  default_result         = "CONTINUE"
  heartbeat_timeout      = 2000
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"
  notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
  role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  notification_metadata = <<EOF
{
  "foo": "bar"
}
EOF
  
}

######################################################
## Launch Template: Auto Scaling Group Notification ##
######################################################
resource "aws_autoscaling_notification" "lt_asg_notification" {
  group_names = []
  notifications = []
  topic_arn = ""
}

resource "aws_sns_topic" "lt_asg_sns_topic" {
  name = ""
}


######################
## New EC2 Instance ##
######################

resource "aws_instance" "ec2_instance" {

  #- System ---------------------------------------------#
  ami           = "" 
  instance_type = "t2.micro"
  user_data = ""
  user_data_base64 = ""
  user_data_replace_on_change = false
  metadata_options {
    http_endpoint = disabled
    http_put_response_hop_limit = 1
    http_tokens = optional
    instance_metadata_tags = "disabled"
  }
  placement_group = ""
  placement_partition_number = 0
  cpu_core_count = 0
  cpu_threads_per_core = 0
  credit_specification {
    cpu_credits = "unlimited"
  }
  
  hibernation = false
  host_id = ""
  maintenance_options = {}
  instance_initiated_shutdown_behavior = {}
  disable_api_termination = false
  #- Storage --------------------------------------------#
  root_block_device = {
    delete_on_termination = false
    encrypted = false
    iops = ""
    throughput = 0
    kms_key_id = ""
    volume_size = 0
    tags = {}
  }
  ebs_block_device = {
    delete_on_termination = false
    device_name = ""
    encrypted = false
    iops = ""
    throughput = 0
    kms_key_id = ""
    snapshot_id = ""
    tags = {}
    volume_size = 0
    volume_type = ""
  }
  ebs_optimized = false
  volume_tags = {}
  ephemeral_block_device {
    device_name = ""
    no_device = ""
    virtual_name = "ephemeral0"
  }
  #- Networking -----------------------------------------#
  associate_public_ip_address = false
  private_ip_address = ""
  secondary_private_ip_addresses = []
  network_interface {
    delete_on_termination = false
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
    network_card_index = 0
  }
  ipv6_addresses_count = 0
  source_dest_check = false
  subnet_id = ""
  #- Security -------------------------------------------#
  enclave_options = {
    enabled = false
  }
  get_password_data = false
  iam_instance_profile = ""
  key_name = ""
  security_groups = [] #EC2-Classic and defaul vpc only
  vpc_security_group_ids = []
  #- Capacity & Auto Scaling ---------------------------------------#
  capacity_reservation_specificiation = {
    capacity_reservation_preference = ""
    capacity_reservation_target = {
      capacity_reservation_id = ""
      capacity_reservation_resource_group_arn = ""
    }
  }
  launch_template = {
    id = ""
    name = ""
    version = ""
  }
  #- Monitoring -----------------------------------------#
  monitoring = false
  #- EC2 Instance Tags ----------------------------------#
  tags = {}
}

#############
## Get AMI ##
#############

resource "aws_ami_copy" "copy_ami" {
  name              = "terraform-example"
  description       = "A copy of ami-xxxxxxxx"
  source_ami_id     = "ami-xxxxxxxx"
  source_ami_region = "us-west-1"
  destination_outpost_arn = ""
  encrypted = false
  kms_key_id = ""

  tags = {
    Name = "HelloWorld"
  }
}

############################
## Copy from Instance AMI ##
############################

resource "aws_ami_from_instance" "copy_from_instance_ami" {
  name               = "terraform-example"
  source_instance_id = "i-xxxxxxxx"
  snapshot_without_reboot = false
  
  tags = {

  }
}

###########################
## AMI Launch Permission ##
###########################

resource "aws_ami_launch_permission" "ami_launch_permission" {
  image_id         = "ami-12345678"
  group = ""
  organization_arn = data.aws_organizations_organization.current.arn
  organizational_unit_arn = ""
  account_id = ""
}

