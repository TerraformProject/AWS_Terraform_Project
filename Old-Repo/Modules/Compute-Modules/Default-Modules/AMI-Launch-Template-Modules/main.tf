locals {
  lt_name         = coalesce(var.lt_name, var.name)
  launch_template = var.create_lt ? aws_launch_template.this[0].name : ""

  block_mapping_kms_key = flatten( [ for mapping, mapping_values in var.block_device_mappings:
                                      [ for new_key, key_values in mapping_values.ebs: key_values if new_key == "new_kms_key_settings" && mapping_values.ebs.create_new_kms_key == true && mapping_values.ebs.snapshot_id == "" ]
                                    ] 
                                  )

  new_ebs_block_device = flatten( [ for ebs_block, ebs_block_vals in var.ebs_block_devices: ebs_block_vals if ebs_block_vals.use_new_snapshot == true ] )

  lt_new_network_interface = flatten( [ for interfaces, interface_values in var.network_interfaces: interface_values if var.create_network_interfaces == true && interface_values.new_network_interface == true ] )

}

################
## Create AMI ##
################

resource "aws_ami" "this_ami" {
count = var.create_new_ami == true ? 1 : 0

  name = var.ami_name 
  description = var.ami_description 
  root_device_name    = var.root_device_name
  architecture = var.architecture
  virtualization_type = var.virtualization_type
  sriov_net_support = lookup(var.virtualization_settings, "sriov_net_support", null)
  image_location = lookup(var.virtualization_settings, "image_location", null)
  kernel_id = lookup(var.virtualization_settings, "kernel_id", null)
  ramdisk_id = lookup(var.virtualization_settings, "ramdisk_id", null)
  
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_devices
    content {
    device_name = ebs_block_device.value.device_name
    delete_on_termination = ebs_block_device.value.delete_on_termination
    volume_type = ebs_block_device.value.volume_type 
    iops = ebs_block_device.value.volume_type == "io1" || ebs_block_device.value.volume_type == "io2" ? ebs_block_device.value.iops : null # (Required only when volume_type is io1 or io2
    snapshot_id = ebs_block_device.value.use_new_snapshot == true ? aws_ebs_snapshot.new_ebs_snapshot[ebs_block_device.value.ebs_key].id : ebs_block_device.value.snapshot_id 
    throughput = ebs_block_device.value.volume_type == "gp3" ? ebs_block_device.value.throughput : null # Only valid for volume_type of gp3
    volume_size = ebs_block_device.value.volume_size #Required unless snapshot_id is set
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_devices
    content {
      device_name = lookup(ephemeral_block_device.value, "device_name", "")
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", "")
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts
    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = var.ami_tags

  depends_on = [
    aws_ebs_volume.new_ebs_volume,
    aws_ebs_snapshot.new_ebs_snapshot
  ]
}

##########################
## New EBS Block Device ##
##########################

resource "aws_ebs_volume" "new_ebs_volume" {
for_each = { for o in local.new_ebs_block_device: o.ebs_key => o}

  availability_zone = each.value.availability_zone
  size              = each.value.volume_size
  type = each.value.volume_type
  throughput = each.value.volume_type == "gp3" ? each.value.throughput : null
  iops = each.value.volume_type == "gp3" || each.value.volume_type == "io1" || each.value.volume_type == "io2" ? each.value.iops : null

  tags = each.value.ebs_tags
}

######################
## New EBS Snapshot ##
######################

resource "aws_ebs_snapshot" "new_ebs_snapshot" {
  for_each = { for o in local.new_ebs_block_device: o.ebs_key => o}
  volume_id = aws_ebs_volume.new_ebs_volume[each.value.ebs_key].id

  tags = each.value.snapshot_tags
}

###########################
## AMI Launch Permission ##
###########################

resource "aws_ami_launch_permission" "ami_launch_permission" {
  for_each = var.create_ami_launch_permissions == true ? var.ami_launch_permissions : {}

  image_id   = aws_ami.this_ami[0].id
  account_id = each.value.account_id
}

#####################
## Launch template ##
#####################

resource "aws_ami_copy" "ami_copy" {
count = var.copy_ami["enable"] == true ? 1 : 0

  name              = var.copy_ami["name"]
  description       = var.copy_ami["description"]
  source_ami_id     = var.copy_ami["source_ami_id"]
  source_ami_region = var.copy_ami["source_ami_region"]
  encrypted = var.copy_ami["encrypted"]
  kms_key_id = var.copy_ami["create_new_kms_key"] == true && var.copy_ami["encrypted"] == true ? aws_kms_key.ami_copy_kms_key["values"].arn : var.copy_ami["kms_key_id"]
  tags = var.copy_ami["tags"]
}

resource "aws_kms_key" "ami_copy_kms_key" {
  for_each = var.copy_ami["enable"] && var.copy_ami["create_new_kms_key"] == true ? var.copy_ami["new_kms_key_settings"] : {}
  description             = each.value.description
  is_enabled = each.value.is_enabled
  policy = each.value.policy == "" ? null : each.value.policy
  enable_key_rotation = each.value.enable_key_rotation
  deletion_window_in_days = each.value.deletion_window_in_days
  tags = each.value.tags
}

resource "aws_ami_from_instance" "instance_ami_copy" {
count = var.copy_instance_ami["enable"] == true ? 1 : 0

  name               = var.copy_instance_ami["name"]
  source_instance_id = var.copy_instance_ami["source_instance_id"]
}

resource "aws_launch_template" "this" {
  count = var.create_lt ? 1 : 0

  ## GENERAL SETTINGS ##

  name        = var.lt_use_name_prefix ? null : local.lt_name
  name_prefix = var.lt_use_name_prefix == true ? "${local.lt_name}-" : null
  description = var.lt_description 

  ## VERSION SETTINGS ##

# update_default_version               = var.update_default_version
  default_version                      = var.default_version

  ## AMI SETTINGS ##

  image_id      = var.use_new_ami == true ? aws_ami.this_ami[0].id : var.use_existing_ami_id == true ? var.existing_ami_id : var.copy_ami["enable"] == true ? aws_ami_copy.ami_copy[0].id : null || var.copy_instance_ami["enable"] == true ? aws_ami_from_instance.instance_ami_copy[0].id : null

  ## PRICE MANAGEMENT SETTINGS ##

  dynamic "instance_market_options" {
    for_each = var.create_instance_market_options == true ? var.instance_market_options : {}
    content {
      market_type = instance_market_options.value.market_type

      dynamic "spot_options" {
        for_each = instance_market_options.value.create_spot_options == true ? instance_market_options.value.spot_options : {}
        content {
          block_duration_minutes         = spot_options.value.block_duration_minutes
          instance_interruption_behavior = spot_options.value.instance_interruption_behavior
          max_price                      = spot_options.value.max_price
          spot_instance_type             = spot_options.value.spot_instance_type
          valid_until                    = spot_options.value.valid_until
        }
      }
    }
  }

  dynamic "license_specification" {
    for_each = var.create_license_specifications == true ? var.license_specifications : {}
    content {
      license_configuration_arn = lookup(license_specification.value, "license_configuration_arn", "" )
    }
  }

  ## INSTANCE SETTINGS ##

  instance_type = var.instance_type
  kernel_id                            = var.kernel_id == "" ? null : var.kernel_id
  ram_disk_id                          = var.ram_disk_id == "" ? null : var.ram_disk_id

  user_data     = var.user_data_local_file_path == "" ? null : base64encode(templatefile(var.user_data_local_file_path, var.user_data_env_vars))

  dynamic "metadata_options" {
    for_each = var.create_metadata_options == true ? var.metadata_options : {}
    content {
      http_endpoint               = metadata_options.value.http_endpoint
      http_tokens                 = metadata_options.value.http_tokens
      http_put_response_hop_limit = metadata_options.value.http_put_response_hop_limit
    }
  }

  dynamic "placement" {
    for_each = var.create_placement == true ? var.placement : {}
    content {
      affinity          = placement.value.affinity
      availability_zone = placement.value.availability_zone
      group_name        = placement.value.group_name
      host_id           = placement.value.host_id
      spread_domain     = placement.value.spread_domain
      tenancy           = placement.value.tenancy
      partition_number  = placement.value.partition_number
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = var.create_capacity_reservation_specification == true ? var.capacity_reservation_specification : {}
    content {
      capacity_reservation_preference = capacity_reservation_specification.value.capacity_reservation_preference
      capacity_reservation_target {
        capacity_reservation_id = lookup(capacity_reservation_specification.value.capacity_reservation_target, "capacity_reservation_id", "" )
      }
    }
  }

  dynamic "hibernation_options" {
    for_each = var.create_hibernation_options == true ? var.hibernation_options : {}
    content {
      configured = lookup(var.hibernation_options, "configured", false )
    }
  }

  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  ## CPU SETTINGS ##

  dynamic "cpu_options" {
    for_each = var.create_cpu_options == true ? var.cpu_options : {}
    content {
      core_count       = lookup(var.cpu_options, "core_count", null )
      threads_per_core = lookup(var.cpu_options, "threads_per_core", null )
    }
  }

  dynamic "credit_specification" {
    for_each = var.create_credit_specification == true ? var.credit_specification : {}
    content {
      cpu_credits = lookup(var.credit_specification, "cpu_credits", "" )
    }
  }

  ## GPU SETTINGS ##

  dynamic "elastic_gpu_specifications" {
    for_each = var.create_elastic_gpu_specifications == true ? var.elastic_gpu_specifications : {}
    content {
      type = lookup(var.elastic_gpu_specifications, "type", "" )
    }
  }

  dynamic "elastic_inference_accelerator" {
    for_each = var.create_elastic_inference_accelerator == true ? var.elastic_inference_accelerator : {}
    content {
      type = lookup(var.elastic_inference_accelerator, "type", "" )
    }
  }

  ## EBS SETTINGS ##

  ebs_optimized = var.ebs_optimized

  dynamic "block_device_mappings" {
    for_each = var.manage_block_device_mappings == true ? var.block_device_mappings : {}
    content {
      device_name  = block_device_mappings.value.device_name
      no_device    = block_device_mappings.value.no_device
      virtual_name = block_device_mappings.value.virtual_name
      ebs {
        snapshot_id           = block_device_mappings.value.ebs.snapshot_id
        delete_on_termination = block_device_mappings.value.ebs.delete_on_termination
        encrypted             = block_device_mappings.value.ebs.snapshot_id != true ? null : block_device_mappings.value.ebs.encrypted
        kms_key_id            = block_device_mappings.value.ebs.snapshot_id != "" ? null : block_device_mappings.value.ebs.create_new_kms_key == true ? aws_kms_key.ebs_kms_key[block_device_mappings.value.ebs.new_kms_key_settings.description].arn : block_device_mappings.value.kms_key_id
        iops                  = block_device_mappings.value.ebs.volume_type == "io1" || block_device_mappings.value.ebs.volume_type == "io2" ? null : block_device_mappings.value.ebs.iops
        throughput            = block_device_mappings.value.ebs.throughput
        volume_size           = block_device_mappings.value.ebs.volume_size
        volume_type           = block_device_mappings.value.ebs.volume_type
      }
    }
  }

  

  ## NETWORKING SETTINGS ##

  disable_api_termination              = var.disable_api_termination

  dynamic "network_interfaces" {
    for_each = var.create_network_interfaces == true ? var.network_interfaces : {}
    content {
      associate_carrier_ip_address = network_interfaces.value.associate_carrier_ip_address
      associate_public_ip_address  = network_interfaces.value.associate_public_ip_address
      delete_on_termination        = network_interfaces.value.delete_on_termination
      description                  = network_interfaces.value.description
      device_index                 = network_interfaces.value.device_index
      ipv4_addresses               = network_interfaces.value.ipv4_addresses
      ipv4_address_count           = network_interfaces.value.ipv4_addresses != 0 ? null : network_interfaces.value.ipv4_address_count
      ipv6_addresses               = network_interfaces.value.ipv6_addresses
      ipv6_address_count           = network_interfaces.value.ipv6_addresses != 0 ? null : network_interfaces.value.ipv6_address_count
      network_interface_id         = network_interfaces.value.new_network_interface == true ? aws_network_interface.new_lt_network_interface[network_interfaces.value.description].id : network_interfaces.value.existing_network_interface_id
      private_ip_address           = network_interfaces.value.primary_private_ip_address
      security_groups              = concat( network_interfaces.value.existing_security_groups, length(networ_interface.value.use_new_security_groups) > 0 ? [ for sec_grp in network_interfaces.value.use_new_security_groups: aws_security_group.launch_template_security_groups[sec_grp].id ] : [] )
      subnet_id                    = network_interfaces.value.subnet_id
      interface_type               = network_interfaces.value.interface_type
    }
  }

  ## SECURITY/MONITORING SETTINGS ##

  vpc_security_group_ids = concat(var.existing_security_group_ids, length(var.use_new_security_groups) > 0 ? [ for sec_grp in var.use_new_security_groups: aws_security_group.launch_template_security_groups[sec_grp].id ] : [] )

  key_name      = var.key_name
  
  dynamic "iam_instance_profile" {
    for_each = var.create_iam_instance_profile == true ? var.iam_instance_profile : {}
    content {
      arn  = lookup(var.iam_instance_profile, "arn", "" )
    }
  }

  dynamic "enclave_options" {
    for_each = var.create_enclave_options == true ? var.enclave_options : {}
    content {
      enabled = lookup(var.enclave_options, "enabled", false )
    }
  }

  dynamic "monitoring" {
    for_each = var.create_monitoring == true ? var.monitoring : {}
    content {
      enabled = lookup(var.monitoring, "enabled", false )
    }
  }

  ## LAUNCH TEMPLATE TAG SETTINGS ##

  dynamic "tag_specifications" {
    for_each = var.create_tag_specifications == true ? var.tag_specifications : {}
    content {
      resource_type = tag_specifications.value.resource_type
      tags          = tag_specifications.value.tags
    }
  }

  tags = var.launch_template_tags

  lifecycle {
    create_before_destroy = true
  }

}

#####################################
## Launch Template New EBS KMS Key ##
#####################################

resource "aws_kms_key" "ebs_kms_key" {
  for_each = { for o in local.block_mapping_kms_key: o.description => o } 
  description             = each.value.description
  is_enabled = each.value.is_enabled
  policy = each.value.policy
  enable_key_rotation = each.value.enable_key_rotation
  deletion_window_in_days = each.value.deletion_window_in_days
  tags = each.value.tags
}

###########################################
## Launch Template New Network Interface ##
###########################################

resource "aws_network_interface" "new_lt_network_interface" {
  for_each = { for o in local.lt_new_network_interface: o.description => o }

  subnet_id       = each.value.subnet_id
  source_dest_check = each.value.source_dest_check
}

#####################################
## Launch Template Security Groups ##
#####################################

resource "aws_security_group" "launch_template_security_groups" {
for_each = var.create_launch_template_security_groups == true && var.create_lt == true ? var.launch_template_security_groups : {}

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
    description      = ingress.value.description == "" ? null : ingress.value.description
    from_port        = ingress.value.from_port  
    to_port          = ingress.value.to_port
    protocol         = ingress.value.protocol
    cidr_blocks      = ingress.value.cidr_blocks == [] ? null : ingress.value.cidr_blocks
    ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks == [] ? null : ingress.value.ipv6_cidr_blocks
    security_groups = ingress.value.security_groups == [] ? null : ingress.value.security_groups
    self = ingress.value.self
    }
  }

  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
    description      = egress.value.description == "" ? null : egress.value.description
    from_port        = egress.value.from_port  
    to_port          = egress.value.to_port
    protocol         = egress.value.protocol
    cidr_blocks      = egress.value.cidr_blocks == [] ? null : egress.value.cidr_blocks
    ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks == [] ? null : egress.value.ipv6_cidr_blocks
    security_groups = egress.value.security_groups == [] ? null : egress.value.security_groups
    self = egress.value.self
    }
  }

  tags = each.value.tags
}




