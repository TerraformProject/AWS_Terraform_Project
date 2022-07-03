locals {
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

launch_template = {
  lt_values = {
      #- Instance Boot -#
      instance_boot = element(matchkeys([for index_key, index_value in var.instance_boot_configurations: index_value], [ for index_key, index_value in var.instance_boot_configurations: index_key], [var.instance_boot_enabled_config_index_key]), 0 )
      # - Instance Types -#
      instance_types = element(matchkeys([for index_key, index_value in var.instance_types_configurations: index_value], [ for index_key, index_value in var.instance_types_configurations: index_key], [var.instance_types_enabled_config_index_key]), 0 )
      #- Instance CPU -#
      instance_cpu = element(matchkeys([for index_key, index_value in var.instance_cpu_configurations: index_value], [ for index_key, index_value in var.instance_cpu_configurations: index_key], [var.instance_cpu_enabled_config_index_key]), 0 )
      #- Instance Memory -#
      instance_memory = element(matchkeys([for index_key, index_value in var.instance_memory_configurations: index_value], [ for index_key, index_value in var.instance_memory_configurations: index_key], [var.instance_memory_enabled_config_index_key]), 0 )
      #- Instance GPU -#
      instance_gpu = element(matchkeys([for index_key, index_value in var.instance_gpu_configurations: index_value], [ for index_key, index_value in var.instance_gpu_configurations: index_key], [var.instance_gpu_enabled_config_index_key]), 0 )
      #- Instance Accelerators
      instance_accelerators = element(matchkeys([for index_key, index_value in var.instance_accelerators_configurations: index_value], [ for index_key, index_value in var.instance_accelerators_configurations: index_key], [var.instance_accelerators_enabled_config_index_key]), 0 )
      #- Instance Storage -#
      instance_storage = element(matchkeys([for index_key, index_value in var.instance_storage_configurations: index_value], [ for index_key, index_value in var.instance_storage_configurations: index_key], [var.instance_storage_enabled_config_index_key]), 0 )
      #- Instance Networking -#
      instance_networking = element(matchkeys([for index_key, index_value in var.instance_networking_configurations: index_value], [ for index_key, index_value in var.instance_networking_configurations: index_key], [var.instance_networking_enabled_config_index_key]), 0 )
      #- Instance Offline -#
      instance_offline = element(matchkeys([for index_key, index_value in var.instance_offline_configurations: index_value], [ for index_key, index_value in var.instance_offline_configurations: index_key], [var.instance_offline_enabled_config_index_key]), 0 )
  }
}

launch_template_requirements = {
  lt_values = {
      # - Instance Types -#
      instance_types = element([ for k, v in element(matchkeys([for index_key, index_value in var.instance_types_configurations: index_value], [ for index_key, index_value in var.instance_types_configurations: index_key], [var.instance_types_enabled_config_index_key]), 0 ): v if k == "requirements" ] , 0 )
      #- Instance CPU -#
      instance_cpu = element([ for k, v in element(matchkeys([for index_key, index_value in var.instance_cpu_configurations: index_value], [ for index_key, index_value in var.instance_cpu_configurations: index_key], [var.instance_cpu_enabled_config_index_key]), 0 ): v if k == "requirements" ] , 0 )
      #- Instance Memory -#
      instance_memory = element([ for k, v in element(matchkeys([for index_key, index_value in var.instance_memory_configurations: index_value], [ for index_key, index_value in var.instance_memory_configurations: index_key], [var.instance_memory_enabled_config_index_key]), 0 ): v if k == "requirements" ] , 0 )
      #- Instance Accelerators
      instance_accelerators = element([ for k, v in element(matchkeys([for index_key, index_value in var.instance_accelerators_configurations: index_value], [ for index_key, index_value in var.instance_accelerators_configurations: index_key], [var.instance_accelerators_enabled_config_index_key]), 0 ): v if k == "requirements" ] , 0 )
      #- Instance Storage -#
      instance_storage = element([ for k, v in element(matchkeys([for index_key, index_value in var.instance_storage_configurations: index_value], [ for index_key, index_value in var.instance_storage_configurations: index_key], [var.instance_storage_enabled_config_index_key]), 0 ): v if k == "requirements" ] , 0 )
      #- Instance Networking -#
      instance_networking = element([ for k, v in element(matchkeys([for index_key, index_value in var.instance_networking_configurations: index_value], [ for index_key, index_value in var.instance_networking_configurations: index_key], [var.instance_networking_enabled_config_index_key]), 0 ): v if k == "requirements" ] , 0 )
      #- Instance Offline -#
      instance_offline = element([ for k, v in element(matchkeys([for index_key, index_value in var.instance_offline_configurations: index_value], [ for index_key, index_value in var.instance_offline_configurations: index_key], [var.instance_offline_enabled_config_index_key]), 0 ): v if k == "requirements" ] , 0 )
  }
}

#####################################################################################################################################################################
#####################################################################################################################################################################

#- GET VALUES WHEN copy_ami IS SPECIFIED -#

  copy_ami = flatten([ for config, config_values in var.instance_boot_configurations: {
                          new_ami_name = lookup( config_values.get_ami_values, "new_ami_name", "" )
                          description = lookup( config_values.get_ami_values, "description", "" )
                          source_ami_id = lookup( config_values.get_ami_values, "source_ami_id", "" )
                          source_ami_region = lookup( config_values.get_ami_values, "source_ami_region", "" )
                          destination_outpost_arn = lookup( config_values.get_ami_values, "destination_outpost_arn", "" )
                          encrypted = lookup( config_values.get_ami_values, "encrypted", false )
                          kms_key_id = lookup( config_values.get_ami_values, "kms_key_id", "" )
                          tags = lookup( config_values.get_ami_values, "copy_ami_tags", {} ) 
                      } if config_values.get_ami_type == "copy_ami" && config == var.instance_boot_enabled_config_index_key
                      ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES WHEN copy_ami_instance IS SPECIFIED -#

copy_ami_instance = flatten([ for config, config_values in var.instance_boot_configurations: {
                                new_ami_name = lookup( config_values.get_ami_values, "new_ami_name", "" )
                                source_instance_id = lookup( config_values.get_ami_values, "source_instance_id", "" )
                                snapshot_without_reboot = lookup( config_values.get_ami_values, "snapshot_without_reboot", false )
                                tags = lookup( config_values.get_ami_values, "copy_ami_instance_tags", {} )
                            } if config_values.get_ami_type == "copy_ami_instance" && config == var.instance_boot_enabled_config_index_key 
] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

# - GET VALUES WHEN CREATING A NEW IAM INSTANCE PROFILE -#

  iam_instance_profile = flatten([ for config, config_values in var.instance_boot_configurations: {
                                      instance_profile_name = config_values.iam_instance_profile.instance_profile_name
                                      path = config_values.iam_instance_profile.path
                                      policy_file = config_values.iam_instance_profile.policy_file
                                  } if config_values.iam_instance_profile.policy_file != "" && config == var.instance_boot_enabled_config_index_key ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES WHEN SPECIFYING A NEW KEY PAIR FOR LAUNCH TEMPLATE -#

  key_pair = flatten([ for config, config_values in var.instance_boot_configurations: {
                            new_key_pair_name = config_values.ssh_key_pair.new_key_pair_name
                            public_key_file = config_values.ssh_key_pair.public_key_file
                          } if config_values.ssh_key_pair.public_key_file != "" && config == var.instance_boot_enabled_config_index_key
                       ] ) 

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES FOR WHEN EXISTING | CREATED AND ENABLED CAPACITY RESERVATIONS ARE SPECIFIED -#

existing_capacity_reservations = flatten( [ for config, config_values in var.instance_types_configurations: {
                                              index_key = "${var.launch_template_name}_existing_capacity_reservation"
                                              preference = config_values.capacity_reservation.existing.preference
                                              capacity_reservation_id = config_values.capacity_reservation.existing.capacity_reservation_id
                                              capacity_reservation_arn = config_values.capacity_reservation.existing.capacity_reservation_resource_group_arn
                                          } if config_values.capacity_reservation.enabled_capacity_reservation_type == "existing" && config == var.instance_types_enabled_config_index_key
 ] )

  create_capacity_reservations = flatten( [ for config, config_values in var.instance_types_configurations: {
                                                index_key = "${var.launch_template_name}_create_capacity_reservation"
                                                preference = config_values.capacity_reservation.create.preference
                                                end_date = config_values.capacity_reservation.create.end_date
                                                end_date_type = config_values.capacity_reservation.create.end_date_type
                                                instance_count = config_values.capacity_reservation.create.instance_count
                                                availability_zone = config_values.capacity_reservation.create.availability_zone
                                                outpost_arn = config_values.capacity_reservation.create.outpost_arn
                                                instance_platform = config_values.capacity_reservation.create.instance_platform
                                                instance_type = config_values.capacity_reservation.create.instance_type
                                                instance_match_criteria = config_values.capacity_reservation.create.instance_match_criteria
                                                tenency = config_values.capacity_reservation.create.tenancy
                                                ebs_optimized = config_values.capacity_reservation.create.ebs_optimized
                                                ephemeral_storage = config_values.capacity_reservation.create.ephemeral_storage
                                                tags = config_values.capacity_reservation.create.tags
                                              } if config_values.capacity_reservation.enabled_capacity_reservation_type == "create" && config == var.instance_types_enabled_config_index_key 
  ] )

  capacity_reservation_object = flatten(concat(local.existing_capacity_reservations, local.create_capacity_reservations))
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES FOR SPOT OPTIONS IF SPOT OPTIONS ARE ENABLED -#

spot_options = flatten([ for config, config_values in var.instance_types_configurations: {
                                index_key = "${var.launch_template_name}-Spot_Options"
                                block_duration_minutes = config_values.spot_options.block_duration_minutes
                                instance_interruption_behavior = config_values.spot_options.instance_interruption_behavior
                                max_price = config_values.spot_options.max_price
                                spot_instance_type = config_values.spot_options.spot_instance_type
                                valid_until = config_values.spot_options.valid_until
                          } if config_values.enable_spot_options == true && config == var.instance_types_enabled_config_index_key
                          ]  )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES FOR PLACEMENT WHEN PLACEMENT IS ENABLED -#

placement = flatten([ for config, config_values in var.instance_types_configurations: {
                                index_key = "${var.launch_template_name}-Placement"
                                host_resource_group_arn = config_values.placement.host_resource_group_arn
                                affinity = config_values.placement.affinity
                                availability_zone = config_values.placement.availability_zone
                                group_name = config_values.placement.group_name
                                host_id = config_values.placement.host_id
                                spread_domain = config_values.placement.spread_domain
                                tenancy = config_values.placement.tenancy
                                partition_number = config_values.placement.partition_number
                          } if config_values.enable_placement == true && config == var.instance_types_enabled_config_index_key
                          ]  )


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#- GET VALUES WHEN KMS KEY IS CREATED AND WHEN create_kms_keys_index_keys == the index key of the created KMS key -#

kms_key = flatten([ for lt_values, lt_values_objects in local.launch_template: [
                      for Storage_kms_Keys, Storage_kms_values in lt_values_objects.instance_storage.create_kms_keys: {
                                index_key = Storage_kms_Keys
                                kms_key_name = Storage_kms_values.kms_key_name
                                key_usage = Storage_kms_values.key_usage
                                cstmr_mstr_key_spec = Storage_kms_values.cstmr_mstr_key_spec
                                is_enabled = Storage_kms_values.is_enabled
                                key_rotation_enabled = Storage_kms_values.key_rotation_enabled
                                policy_file = Storage_kms_values.policy_file != "" ? file(Storage_kms_values.policy_file) : ""
                                bypass_policy_lockout_safety_check = Storage_kms_values.bypass_policy_lockout_safety_check
                          } ] ] )

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

## GATHERING GET/CREATE SECURITY GROUPS ##

  lt_get_sec_grp = flatten( [ for config, config_values in var.instance_networking_configurations: [
                                for sec_grps, vals in config_values.get_create_security_groups: {
                                  index_key = sec_grps
                                  secgrp_value = vals
                                } if element(split("_", sec_grps), 0 ) == "get" && config == var.instance_networking_enabled_config_index_key
  ] ] )

 join_merge_lt_sec_grp = merge({ for o in local.lt_get_sec_grp: o.index_key => o })

 lt_create_sec_grp = flatten( [ for config, config_values in var.instance_networking_configurations: [
                                for sec_grps, vals in config_values.get_create_security_groups: {
                                  index_key = sec_grps
                                  rules = toset(vals)
                                } if element(split("_", sec_grps), 0 ) == "create" && config == var.instance_networking_enabled_config_index_key
  ] ] )

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
  tags = each.value.tags
}

############################
## Copy from Instance AMI ##
############################

resource "aws_ami_from_instance" "copy_from_instance_ami" {
for_each = { for o in local.copy_ami_instance: o.new_ami_name => o }

  name               = each.value.new_ami_name
  source_instance_id = each.value.source_instance_id
  snapshot_without_reboot = each.value.snapshot_without_reboot
  tags = each.value.tags
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

#####################################################
## Create Capacity Reservation for Launch Template ##
#####################################################

resource "aws_ec2_capacity_reservation" "capacity_reservation" {
for_each = { for o in local.create_capacity_reservations: o.index_key => o }

  end_date = each.value.end_date
  end_date_type = each.value.end_date_type
  instance_count = each.value.instance_count
  availability_zone = each.value.availability_zone
  outpost_arn = each.value.outpost_arn
  #- Required Criteria to Activate -#
  instance_platform = each.value.instance_platform
  instance_type = each.value.instance_type
  #- Optional Criteria to Activate -#
  instance_match_criteria = each.value.instance_match_criteria
  tenancy = each.value.tenency
  ebs_optimized = each.value.ebs_optimized
  ephemeral_storage = each.value.ephemeral_storage
  tags = each.value.tags
}

#####################
## Create KMS Keys ##
#####################
resource "aws_kms_key" "lt_create_kms_key" {
for_each = { for o in local.kms_key: o.index_key => o }

  key_usage = each.value.key_usage
  customer_master_key_spec = each.value.cstmr_mstr_key_spec
  is_enabled = each.value.is_enabled
  enable_key_rotation = each.value.key_rotation_enabled
  policy = each.value.policy_file == "" ? null : file(each.value.policy_file)
  bypass_policy_lockout_safety_check = each.value.bypass_policy_lockout_safety_check

  tags = {
    Name = each.value.kms_key_name
  }
}

##################################
## Get Security Group ID by Tag ##
##################################

data "aws_security_group" "lt_get_security_group" {
for_each = { for o in local.join_merge_lt_sec_grp: o.index_key => o }

  tags = each.value.secgrp_value
}

###########################
## Create Security Group ##
###########################

resource "aws_security_group" "lt_create_security_group" {
 for_each = { for o in local.lt_create_sec_grp: o.index_key => o }

  name = each.value.index_key
 # vpc_id = each.value.vpc_id

  dynamic "ingress" {
  for_each = { for o in each.value.rules: element( split("|", o ) , 6 ) => o if element( split("|", o) , 0 ) == "Ingress" } 
  # for_each = toset([ for o in each.value.rule_values: o if element( split("|", o) , 0 ) == "Ingress" ])
  # for_each = { for o in local.lt_create_sec_grp: o.rule_name => o if o.direction == "Ingress"}
  content {
      cidr_blocks = element( split("|", ingress.value) , 1 ) == "IPv4" ? [element( split("|", ingress.value) , 2 )] : []
      ipv6_cidr_blocks = element( split("|", ingress.value) , 1 ) == "IPv6" ? [element( split("|", ingress.value) , 2 )] : []
      security_groups = element( split("|", ingress.value) , 1 ) == "Security_Groups" ? [element( split("|", ingress.value) , 2 )] : []
      prefix_list_ids = element( split("|", ingress.value) , 1 ) == "Prefix_List_IDs" ? [element( split("|", ingress.value) , 2 )] : []
      protocol  = element( split("|", ingress.value) , 3 ) 
      from_port = element( split("|", ingress.value) , 4 )
      to_port   = element( split("|", ingress.value) , 5 )
    }
  }

  dynamic "egress" {
    for_each = { for o in each.value.rules: element( split("|", o ) , 6 ) => o if element( split("|", o) , 0 ) == "Egress" } 
    #for_each = toset([ for o in each.value.rule_values: o if element( split("|", o) , 0 ) == "Egress" ])
    #for_each = { for o in local.lt_create_sec_grp: o.rule_name => o if o.direction == "Egress"}
    content {
      cidr_blocks = element( split("|", egress.value) , 1 ) == "IPv4" ? [element( split("|", egress.value) , 2 )] : []
      ipv6_cidr_blocks = element( split("|", egress.value) , 1 ) == "IPv6" ? [element( split("|", egress.value) , 2 )] : []
      security_groups = element( split("|", egress.value) , 1 ) == "Security_Groups" ? [element( split("|", egress.value) , 2 )] : []
      prefix_list_ids = element( split("|", egress.value) , 1 ) == "Prefix_List_IDs" ? [element( split("|", egress.value) , 2 )] : []
      protocol  = element( split("|", egress.value) , 3 ) 
      from_port = element( split("|", egress.value) , 4 )
      to_port   = element( split("|", egress.value) , 5 )
      }
    }

  tags = merge(
    {
      "Name" = each.value.index_key
    },
  )
}

######################################################################################################################################################

##########################################
#- Launch Template State ----------------#
##########################################

resource "aws_launch_template" "new_ec2_launch_template" {
for_each = local.launch_template
  
  name = var.launch_template_name_prefix == true ? null : var.launch_template_name
  name_prefix = var.launch_template_name_prefix == true ? "${var.launch_template_name}-" : null
  description = var.description
  default_version = var.update_default_version == true ? null : var.default_version
  update_default_version = var.update_default_version == false ? null : var.update_default_version

  ###################
  #- Instance Boot -#
  ###################
  #- AMI -#
  image_id = each.value.instance_boot.get_ami_type == "ami_id" ? each.value.instance_boot.get_ami_values.ami_id : each.value.instance_boot.get_ami_type == "copy_ami" ? aws_ami_copy.copy_ami[each.value.instance_boot.get_ami_values.new_ami_name].id : each.value.instance_boot.get_ami_type == "copy_ami_instance" ? aws_ami_from_instance.copy_from_instance_ami[each.value.instance_boot.get_ami_values.new_ami_name].id : null

  #- Licensing -#
  dynamic "license_specification" {
  for_each = each.value.instance_boot.license_configuration_arn == "" ? {} : local.launch_template
  content {
    license_configuration_arn = license_specification.value.license_configuration_arn
    }
  }

  #- User Data -#
  user_data = each.value.instance_boot.user_data.file == "" ? "" : base64encode(templatefile(each.value.instance_boot.user_data.file, each.value.instance_boot.user_data.vars ))
  metadata_options {
    http_endpoint = each.value.instance_boot.metadata_options.http_endpoint # enabled | disabled # 
    http_tokens = each.value.instance_boot.metadata_options.http_tokens # optional | required
    http_put_response_hop_limit = each.value.instance_boot.metadata_options.http_put_response_hop_limit
    http_protocol_ipv6 = each.value.instance_boot.metadata_options.htttp_protocol_ipv6 # enabled | disabled
    instance_metadata_tags = each.value.instance_boot.metadata_options.instance_metadata_tags # enabled | disabled
  }

  #- Access -#
  iam_instance_profile {
    arn = each.value.instance_boot.iam_instance_profile.instance_profile_name != "" ? aws_iam_instance_profile.instance_profile[each.value.instance_boot.iam_instance_profile.instance_profile_name].arn : each.value.instance_boot.iam_instance_profile.arn
  }
  key_name = each.value.instance_boot.ssh_key_pair.public_key_file != "" ? aws_key_pair.lt_key_pair[each.value.instance_boot.ssh_key_pair.new_key_pair_name].key_name : each.value.instance_boot.ssh_key_pair.existing_key_pair_name

  #- Monitoring -#
  monitoring {
    enabled = each.value.instance_boot.enable_detailed_instance_monitoring
  }

  ####################
  #- Instance Types -#
  ####################
  instance_type = each.value.instance_types.instance_type

  dynamic "instance_market_options" {
  for_each = { for o in local.spot_options: o.index_key => o }
  content {
    market_type = "spot"
    spot_options {
      block_duration_minutes = instance_market_options.value.block_duration_minutes == 0 ? null : instance_market_options.value.block_duration_minutes
      instance_interruption_behavior = instance_market_options.value.instance_interruption_behavior
      max_price = instance_market_options.value.max_price
      spot_instance_type = instance_market_options.value.spot_instance_type
      valid_until = instance_market_options.value.valid_until
    }
    }
  }

  dynamic "capacity_reservation_specification" {
  for_each = { for o in local.capacity_reservation_object: o.index_key => o }
  # for_each = merge( { for o in local.existing_capacity_reservations: o.index_key => o }, local.create_capacity_reservations )
  #for_each = each.value.instance_types.capacity_reservation.enabled_capacity_reservation_type != "none" ? {for o in local.capacity_reservation_object: o.index_key => o } : {}
  content {
    capacity_reservation_preference = capacity_reservation_specification.value.preference != "null" ? capacity_reservation_specification.value.preference : null
    capacity_reservation_target {
      capacity_reservation_id = each.value.instance_types.capacity_reservation.enabled_capacity_reservation_type == "create" ? aws_ec2_capacity_reservation.capacity_reservation[capacity_reservation_specification.value.index_key].id : capacity_reservation_specification.value.capacity_reservation_id == "existing" ? null : capacity_reservation_specification.value.capacity_reservation_id == ""
      capacity_reservation_resource_group_arn = each.value.instance_types.capacity_reservation.enabled_capacity_reservation_type == "existing" ? capacity_reservation_specification.value.capacity_reservation_arn : null
    }
  }
  }
  

  dynamic "placement" {
  for_each = { for o in local.placement: o.index_key => o }
  content {
    affinity = each.value.instance_types.placement.affinity
    availability_zone = each.value.instance_types.placement.availability_zone
    group_name = each.value.instance_types.placement.group_name
    host_id = each.value.instance_types.placement.host_id == "" ? null : each.value.instance_types.placement.host_id
    host_resource_group_arn = each.value.instance_types.placement.host_resource_group_arn == "" ? null : each.value.instance_types.placement.host_resource_group_arn
    spread_domain = each.value.instance_types.placement.spread_domain
    tenancy = each.value.instance_types.placement.tenancy
    partition_number = each.value.instance_types.placement.partition_number
    }
  }

  ## Other Instance Type specs are located within the Instance Requirements section below ##

  ######################
  #- CPU Per Instance -#
  ######################
  cpu_options {
    core_count = each.value.instance_cpu.core_count
    threads_per_core = each.value.instance_cpu.threads_per_core
  }
  credit_specification {
    cpu_credits = each.value.instance_cpu.cpu_credits # standard | unlimited
  }
  elastic_inference_accelerator {
    type = each.value.instance_cpu.elastic_inference_accelerator_type
  }
  enclave_options {
    enabled = each.value.instance_cpu.enable_nitro_enclaves
  }

  ## Other Instance CPU specs are located within the Instance Requirements section below ##

  #########################
  #- Memory Per Instance -#
  #########################
  kernel_id = each.value.instance_memory.kernal_id
  ram_disk_id = each.value.instance_memory.ram_disk_id

   ## Instance Memory specs are located within the Instance Requirements section below ##

  ######################
  #- GPU Per Instance -#
  ######################
  elastic_gpu_specifications {
      type = each.value.instance_gpu.gpu_type
  }
  ########################################
  #- Instance Accelerators Per Instance -#
  ########################################

  ## Instance Accelerator specs are located within the Instance Requirements section below ##

  ######################
  #- Instance Storage -#
  ######################
  ebs_optimized = each.value.instance_storage.ebs_optimized
  dynamic "block_device_mappings" {
  for_each = each.value.instance_storage.block_device_mappings
  content {
    device_name = block_device_mappings.value.device_name
    no_device = block_device_mappings.value.no_device
    virtual_name = lookup(block_device_mappings.value, "virtual_name", null)
    ebs {
        delete_on_termination = lookup(block_device_mappings.value, "delete_on_termination", null)
        encrypted = block_device_mappings.value.encrypted
        kms_key_id = block_device_mappings.value.create_kms_key_index_key != null ? aws_kms_key.lt_create_kms_key[block_device_mappings.value.create_kms_key_index_key].arn : block_device_mappings.valuekms_key_id
        volume_type = lookup(block_device_mappings.value, "volume_type", null)
        iops = lookup(block_device_mappings.value, "volume_type", "") != "io1" || lookup(block_device_mappings.value, "volume_type", "") != "io2" ? null : block_device_mappings.value.iops
        throughput = lookup(block_device_mappings.value, "volume_type", "" ) != "gp3" ? null : block_device_mappings.value.throughput 
        volume_size = block_device_mappings.value.volume_size
        snapshot_id = block_device_mappings.value.snapshot_id
      }
    }
  }
  
## Other Instance Storage specs are located within the Instance Requirements section below ##

  #########################
  #- Instance Networking -#
  #########################
  dynamic "network_interfaces" {
  for_each = each.value.instance_networking.network_interfaces
  content {
    #- Existing ENI -#
    network_interface_id = network_interfaces.value.get_eni_by_id
    #network_interface_id = network_interfaces.value.get_eni_by_tag != {} ? element(data.aws_network_interfaces.get_eni_id_tag[element( keys(network_interfaces.value.get_eni_by_tag) , 0 )].ids, 0 ) : network_interfaces.value.get_eni_by_id != "" ? network_interfaces.value.get_eni_by_id : null
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
  } 
  }
  private_dns_name_options {
    enable_resource_name_dns_aaaa_record = each.value.instance_networking.private_dns_name_options.enable_resource_name_dns_aaaa_record
    enable_resource_name_dns_a_record = each.value.instance_networking.private_dns_name_options.enable_resource_name_dns_a_record
    hostname_type = each.value.instance_networking.private_dns_name_options.hostname_type
  }

  ##########################################
  #- Instance Requirements ----------------#
  ##########################################
  dynamic "instance_requirements" {
  for_each = each.value.instance_types.instance_type != "" ? {} : local.launch_template_requirements
  content {

  ###################
  #- Instance Boot -#
  ###################

  ## No Instance Boot requirements are to be specified ##

  ####################
  #- Instance Types -#
  ####################
  instance_generations = each.value.instance_types.instance_type_requirements.instance_generations
  excluded_instance_types = each.value.instance_types.instance_type_requirements.excluded_instance_types
  bare_metal = each.value.instance_types.instance_type_requirements.bare_metal_instances

  ######################
  #- CPU Per Instance -#
  ######################
  cpu_manufacturers = each.value.instance_cpu.instance_cpu_requirements.cpu_manufacturers
  vcpu_count {
        min = each.value.instance_cpu.instance_cpu_requirements.vcpu_count.min
        max = each.value.instance_cpu.instance_cpu_requirements.vcpu_count.max
  }
  burstable_performance = each.value.instance_cpu.instance_cpu_requirements.burstable_performance

  #########################
  #- Memory Per Instance -#
  #########################
  memory_mib {
        min = each.value.instance_memory.instance_memory_requirements.memory_mib.min
        max = each.value.instance_memory.instance_memory_requirements.memory_mib.max
  }
  memory_gib_per_vcpu {
        min = each.value.instance_memory.instance_memory_requirements.memory_gib_per_vcpu.min
        max = each.value.instance_memory.instance_memory_requirements.memory_gib_per_vcpu.max
  }

  ######################
  #- GPU Per Instance -#
  ######################

  ## No Instance GPU requirements are to be specified ##

  ########################################
  #- Instance Accelerators Per Instance -#
  ########################################
  accelerator_manufacturers = each.value.instance_accelerators.instance_accelerator_requirements.accelerator_manufacturers
  accelerator_names = each.value.instance_accelerators.instance_accelerator_requirements.accelerator_names
  accelerator_types = each.value.instance_accelerators.instance_accelerator_requirements.accelerator_types
  accelerator_count { 
        min = each.value.instance_accelerators.instance_accelerator_requirements.accelerator_count.min
        max = each.value.instance_accelerators.instance_accelerator_requirements.accelerator_count.max
  }
  accelerator_total_memory_mib {
          min = each.value.instance_accelerators.instance_accelerator_requirements.accelerator_total_memory_mib.min
          max = each.value.instance_accelerators.instance_accelerator_requirements.accelerator_total_memory_mib.max
  }  

  ######################
  #- Instance Storage -#
  ######################
  local_storage = each.value.instance_storage.instance_storage_requirements.local_storage
  local_storage_types = each.value.instance_storage.instance_storage_requirements.local_storage_types
  total_local_storage_gb {
        min = each.value.instance_storage.instance_storage_requirements.total_local_storage_gb.min
        max = each.value.instance_storage.instance_storage_requirements.total_local_storage_gb.max
  }  
  baseline_ebs_bandwidth_mbps {
        min = each.value.instance_storage.instance_storage_requirements.baseline_ebs_bandwidth_mbps.min
        max = each.value.instance_storage.instance_storage_requirements.baseline_ebs_bandwidth_mbps.max
  }

  #########################
  #- Instance Networking -#
  #########################
  network_interface_count {
        min = each.value.instance_networking.instance_networking_requirements.network_interface_count.min
        max = each.value.instance_networking.instance_networking_requirements.network_interface_count.max
  }

  ######################
  #- Instance Offline -#
  ######################
  require_hibernate_support = each.value.instance_offline.instance_offline_requirement.hibernation_option_enabled
  }
  }

  ######################################
  #- Instance Offline -----------------#
  ######################################
  maintenance_options {
    auto_recovery = each.value.instance_offline.auto_recovery_enabled
  }
  disable_api_termination = each.value.instance_offline.disable_api_termination
  instance_initiated_shutdown_behavior = each.value.instance_offline.instance_initiated_shutdown_behavior

  ##########################################
  #- Launch Template Tags -----------------#
  ##########################################
  dynamic "tag_specifications" {
  for_each = var.tag_specifications
  content {
    resource_type = tag_specifications.value.resource_type
    tags = {
      (tag_specifications.value.tag_key) = (tag_specifications.value.tag_value)
      }
    }
  }
  
  ##################################
  #- Launch Template Dependencies -#
  ##################################
  depends_on = [
    aws_security_group.lt_create_security_group
  ]
}
