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
