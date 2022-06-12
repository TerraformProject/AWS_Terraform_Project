locals {
  
## Gathering Get/Create Security Groups ##

    lt_get_sec_grp = flatten([ for secgrp, secgrp_vals in var.get_create_security_groups: {
                                secgrp_key = secgrp
                                secgrp_value = secgrp_vals
                              } if element(split("_", secgrp), 0 ) == "get" ])

    join_merge_lt_sec_grp = merge(join(", ", local.lt_get_sec_grp))

    lt_create_sec_grp = flatten([ for secgrp, secgrp_vals in var.get_create_security_groups: 
                                        [ for rule_values in secgrp_vals : {
                                            secgrp_key = secgrp
                                            direction = element( split("|", rule_values) , 0 )
                                            type = element( split("|", rule_values) , 1 )
                                            type_value = element( split("|", rule_values) , 2 )
                                            protocol = element( split("|", rule_values) , 3 )
                                            from_port = element( split("|", rule_values) , 4 )
                                            to_port = element( split("|", rule_values) , 5 )
                                            rule_name = element( split("|", rule_values) , 6 )
                                        } ] 
                                        if element(split("_", secgrp), 0 ) == "create"
                                         ] )
  ## Gathering Get/Create KMS Keys ##

  lt_get_kms_key = flatten([ for kms_key, kms_key_vals in var.get_create_kms_keys: {
                                kms_key_key = kms_key
                                kms_key_value = kms_key_vals
                            } if element(split("_", kms_key), 0 ) == "get" ])

  join_merge_lt_kms_key = merge(join(", ", local.lt_get_kms_key))

  lt_create_kms_key = flatten([ for kms_key, kms_key_vals in get_create_kms_keys:  {
                                  kms_key_key = kms_key
                                  kms_key_name = kms_key_vals.kms_key_name
                                  key_usage = kms_key_vals.key_usage
                                  cstmr_mstr_key_spec = kms_key_vals.cstmr_mstr_key_spec
                                  is_enabled = kms_key_vals.is_enabled
                                  key_rotation_enabled = kms_key_vals.key_rotation_enabled
                                  policy_file = kms_key_vals.policy_file
                                  bypass_policy_lockout_safety_check = kms_key_vals.bypass_policy_lockout_safety_check
                              } 
                              if element(split("_", kms_key), 0 ) == "create"
                              ] )

}

#############################
## New EC2 Launch Template ##
#############################

resource "aws_launch_template" "new_ec2_launch_template" {
  
  ##########################################
  #- Launch Template State ----------------#
  ##########################################
  name = ""
  name_prefix = ""
  description = ""
  default_version = ""
  update_default_version = false
  ##########################################
  #- Instance State -----------------------#
  ##########################################
  disable_api_termination = false
  image_id = ""
  instance_type = ""
  instance_initiated_shutdown_behavior = "" # stop | terminate
  instance_requirements = {
        accelerator_count = {
          min = 0
          max = 0
        }
        accelerator_manufacturers = []
        accelerator_names = []
        accelerator_total_memory_mib = {
          min = 0
          max = 0
        }
        accelerator_types = []
        bare_metal = "" # included | excluded | required
      
      baseline_ebs_bandwidth_mbps = {
        min = 0
        max = 0
      }
      burstable_performance = "" # included | excluded | required
      cpu_manufacturers = []
      excluded_instance_types = []
      instance_generations = []
      local_storage = "" # included | excluded | required
      local_storage_types = []
      memory_gib_per_vcpu = {
        min = 0
        max = 0
      }
      memory_mib = {
        min = 0
        max = 0
      }
      network_interface_count = {
        min = 0
        max = 0
      }
      on_demand_max_price_percentage_over_lowest_price = 0
      spot_max_price_percentage_over_lowest_price = 0
      require_hibernate_support = false
      total_local_storage_gb = {
        min = 0
        max = 0
      }
      vcpu_count = {
        min = 0
        max = 0
      }
  }
  ##########################################
  #- Instance_Maintenance -----------------#
  ##########################################
  user_data = ""
  metadata_options {
    http_endpoint = "" # enabled | disabled 
    http_tokens = "" # optional | required
    http_put_response_hop_limit = 1
    htttp_protocol_ipv6 = "" # enabled | disabled
    instance_metadata_tags = "" # enabled | disabled
  }
  maintenance_options = {
    auto_recovery = "" # default | disabled
  }
  monitoring {
    enabled = false
  }
  ##########################################
  #- System State -------------------------#
  ##########################################
  hibernation_options {
    configured = false
  }
  kernel_id = ""
  ram_disk_id = ""
  ##########################################
  #- CPU State ----------------------------#
  ##########################################
  cpu_options {
    core_count = 0
    threads_per_core = 0
  }

  credit_specification {
    cpu_credits = "" # standard | unlimited
  }
  elastic_inference_accelerator {
    type = ""
  }
  ##########################################
  #- Block State --------------------------#
  ##########################################
  block_device_mappings {
    device_name = ""
    no_device = ""
    virtual_name = "ephemeralN"
    ebs {
      delete_on_termination = false
      encrypted = false # if snapshot_id != "" then conflict
      kms_key_id = ""
      volume_type = ""
      iops = 0
      throughput = 0
      volume_size = 0
      snapshot_id = "" 
    }
  }
  ebs_optimized = true
  ##########################################
  #- GPU State ----------------------------#
  ##########################################
  elastic_gpu_specifications {
    type = ""
  }
  ##########################################
  #- Networking State ---------------------#
  ##########################################
  
  network_interfaces {
    associate_carrier_ip_address = false
    associate_public_ip_address = false
    delete_on_termination = false
    description = ""
    device_index = 0
    interface_type = "" # efa
    ipv4_prefix_count = 0 # If > 0 && ipv4_prefixes != [] then conflict
    ipv4_prefixes = [] # if != [] && ipv4_prefix_count > 0 then conflict
    ipv6_addresses = [] # if != [] && ipv6_address_count > 0 then conflict
    ipv6_address_count = 0 # If > 0 && ipv6_addresses != [] then conflict
    ipv6_prefix_count = 0 # If > 0 && ipv6_prefixes != [] then conflict
    ipv6_prefixes = [] # # if != [] && ipv6_prefix_count > 0 then conflict
    network_interface_id = ""
    network_card_index = 0
    private_ip_address = "" # Primary IPv4
    ipv4_address_count = 0 # If > 0 && ipv4_addresses != [] then conflict
    ipv4_addresses = [] # # if != [] && ipv4_address_count > 0 then conflict
    security_groups = [] #IDs
    subnet_id = ""
  }
  security_group_names = []
  vpc_security_group_ids = []
  private_dns_name_options {
    enable_resource_name_dns_aaaa_record = false
    enable_resource_name_dns_a_record = false
    hostname_type = "" # ip-name | resource-name
  }
  ##########################################
  #- Security State -----------------------#
  ##########################################
  enclave_options {
    enabled = false
  }
  iam_instance_profile {
    name = ""
    arn = ""
  }
  key_name = ""
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
  license_specification {
    license_configuration_arn = ""
  }
  ##########################################
  #- Launch Template Tags -----------------#
  ##########################################
  tag_specifications {
    
  }
  tags = {}
}

################################################################################

#####################################
## Launch Template Security Groups ##
#####################################

data "aws_security_group" "lt_get_security_group" {
for_each = { for o in local.join_merge_lt_sec_grp: o.secgrp_key => o }

  tags = each.value.secgrp_value
}


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

###############################
## Launch Template: KMS Keys ##
###############################
resource "aws_kms_key" "lt_create_kms_key" {
for_each = { for o in local.lt_create_kms_key: o.kms_key => o }

  description = ""
  key_usage = "" # ENCRYPT_DECRYPT | SIGN_VERIFY
  customer_master_key_spec = ""
  policy = ""
  bypass_policy_lockout_safety_check = false 
  is_enabled = true
  enable_key_rotation = false
  multi_region = false

  tags = {
    Name = ""
  }
}

##########################################
## Launch Template: Auto Scaling Groups ##
##########################################

resource "aws_autoscaling_group" "lt_auto_scaling_group" {
  name = ""
  name_prefix = ""
  service_linked_role_arn = ""

  #- PLacement -#
  availability_zones = [] # Used for EC2 Classic
  vpc_zone_identifier = []
  placement_group = ""
  load_balancers = [] # Classic Load Balancers Only
  target_group_arns = []
  min_elb_capacity = false
  wait_for_elb_capacity = 0

  #- Scaling -#
  max_size = 0
  min_size = 0
  metrics_granularity = ""
  enabled_metrics = false
  capacity_rebalance = false
  default_cooldown = 0
  desired_capacity = 0
  wait_for_capacity_timeout = ""
  health_check_grace_period = 300
  health_check_type = "EC2"
  protect_from_scale_in = false
  instance_refresh {
    triggers = []
    strategy = "Rolling"
    preferences {
        checkpoint_delay = 0
        checkpoint_percentages = 100
        instance_warmup = 0
        min_health_percentage = 0
    } 
  }
  max_instance_lifetime = 0
  suspended_processes = []
  termination_policies = []
  force_delete = false
 
  #- ASG Instances -#
  launch_template {
    id = ""
    name = ""
    version = ""
  }
  warm_pool {
    pool_state = ""
    min_size = 0
    instance_reuse_policy { reuse_on_scale_in = false }
    max_group_prepared_capacity = 0
  }
  mixed_instances_policy {
    instances_distribution {
        on_demand_allocation_strategy = "prioritized"
        on_demand_base_capacity = 0
        on_demand_percentage_above_base_capacity = 100
        spot_allocation_strategy = "" 
        spot_instance_pools = 0
        spot_max_price = ""
    }
    launch_template {
        launch_template_specification {
            launch_template_id = ""
            launch_template_name = ""
            version = ""
        }
        override {
            weighted_capacity = 0
            instance_type = ""
            launch_template_specification {
                  launch_template_id = ""
                  launch_template_name = ""
                  version = ""
            }
            instance_requirements {
                  #- Instances -#
                  instance_generations = []
                  excluded_instance_types = []
                  on_demand_max_price_percentage_over_lowest_price = 0
                  spot_max_price_percentage_over_lowest_price = 0
                  bare_metal = ""
                  require_hibernate_support = false
                  #- CPU -#
                  cpu_manufacturers = []
                  vcpu_count {
                    min = 0
                    max = 0
                  }
                  burstable_performance = ""
                  #- Accelerators -#
                  accelerator_types = []
                  accelerator_manufacturers = []
                  accelerator_names = []
                  accelerator_count {
                    min = 0
                    max = 0
                  }
                  accelerator_total_memory_mib {
                    min = 0
                    max = 0
                  }
                  #- RAM -#
                  memory_gib_per_vcpu {
                    min = 0
                    max = 0
                  }
                  memory_mib {
                    min = 0
                    max = 0
                  }
                  #- Storage -#
                  local_storage = ""
                  total_local_storage_gb {
                    min = 0
                    max = 0
                  }
                  baseline_ebs_bandwidth_mbps {
                    min = 0
                    max = 0
                  }
                  #- ENI -#
                  network_interface_count {
                    min = 0
                    max = 0
                  }     
          }    
        }
      }
  }

  #-ASG Tags -#
  tag {
        key = ""
        value = ""
        propgate_at_launch = false
  }
  tags = [
        {
        key = ""
        value = ""
        propgate_at_launch = false
        }
      ] 
}

################################################
## Launch Template: Auto Scaling Group Policy ##
################################################
resource "aws_autoscaling_policy" "lt_auto_scaling_group_policy" {
  enabled = false
  name = ""
  autoscaling_group_name = ""
  adjustment_type = "" # ChangeInCapacity | ExactCapacity | PercentChangeInCapacity
  policy_type = "" # SimpleScaling | StepScaling | TargetTrackingScaling | PredictiveScaling
  #- Only Applies to "SimpleScaling" and "StepScaling" -#
  min_adjustment_magnitude = 0
  #- Only Applies to "SimpleScaling" -#
  cooldown = 0
  scaling_adjustment = 0 # adjustment_type detirmines how this is is interpreted: number | percent
  #- Only Applies to "StepScaling" -#
  metric_aggregation_type = "" # Minimum | Maximum | Average
  step_adjustment {
    scaling_adjustment = 0
    metric_interval_lower_inbound = 0
    metric_interval_upper_bound = 0
  }
  #- Only Applies to "TargetTrackingScaling" -#
  target_tracking_configuration {
    predifined_metric_specification { # Conflicts with customize_metric_specification
        predidined_metric_type = ""
        resource_label = ""
    } 
    customized_metric_specification { # Conflicts with predifined_metric_specification
        metric_name = ""
        metric_dimension {
          name = ""
          value = ""
        }
        statistic = ""
        unit = 0
        namespace = ""
    } 
    target_value = 0
    disable_scale_in = false
  }
  estimated_instance_warmup = 0
  predictive_scaling_configuration {
    max_capacity_breach_behavior = "" # HonorMaxCapacity | IncreaseMaxCapacity 
    max_capacity_buffer = 0
    mode = "" # ForecastAndScale | ForecastOnly
    scheduling_buffer_time = 0
    metric_specification {
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
        customized_load_metric_specification {
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
        predefined_load_metric_specification {
            predefined_metric_type = "" # ASGTotalCPUUtilization | ASGTotalNetworkIn | ASGTotalNetworkOut
            resource_label = ""
        }
        predefined_metric_pair_specification {
            predefined_metric_type = "" # ASGCPUUtilization | ASGNetworkIn | ASDNetworkOut | ALBRequestCount
            resource_label = ""
        }
        predefined_scaling_metric_specification {
            predefined_metric_type = "" # ASGAverageCPUUtilization | ASGAverageNetworkIN | ASGAverageNetworkOut | ALBRequestCountPerTarget
            resource_label = ""
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

########################################################
## Launch Template: Auto Scaling Group Lifecycle Hook ##
########################################################
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

