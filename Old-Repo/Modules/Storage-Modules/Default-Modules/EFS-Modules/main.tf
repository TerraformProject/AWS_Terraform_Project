locals {

    ## Get EFS Mount Targets to Iterate ##

        # Get EFS IDs #
        efs_id = [ for efs_key, efs_vals in var.efs_file_systems: aws_efs_file_system.efs[efs_key].id ]

        mount_targets = flatten( [ for efs, efs_vals in var.efs_file_systems: 
                                    [ for target, target_vals in efs_vals.mount_targets: {
                                          module_key = target_vals.module_key
                                          file_system_id = aws_efs_file_system.efs[ efs ].id
                                          ip_address = target_vals.ip_address
                                          subnet_id = target_vals.subnet_id 
                                          new_subnet = {
                                            enabled = target_vals.new_subnet.enabled
                                            cidr_block = target_vals.new_subnet.cidr_block
                                          }
                                          security_groups = target_vals.security_groups
                                          new_security_group = target_vals.new_security_group
                                      }
                                    ] 
                                ] )

        # Get Mount Target New Subnet to Iterate #
        mount_target_new_subnet = flatten( [ for efs, efs_vals in var.efs_file_systems: 
                                            [ for target, target_vals in efs_vals.mount_targets: target_vals.new_subnet if target_vals.new_subnet.enabled == true ] ] )

        # Get Mount Target New Security Group to Iterate #
        new_security_group = flatten( [ for efs, efs_vals in var.efs_file_systems: 
                                        [ for target, target_vals in efs_vals.mount_targets: target_vals.new_security_group if target_vals.new_security_group.enabled == true ] ] )

    ## Get EFS Access Point to Iterate ##
    efs_access_point = flatten( [ for efs, efs_vals in var.efs_file_systems: {
      file_system_id = aws_efs_file_system.efs[ efs ].id
      module_key = efs_vals.access_point.module_key
      root_directory = efs_vals.access_point.root_directory
      posix_user = efs_vals.access_point.posix_user
    }
    if efs_vals.access_point.enabled == true ] )
    ## Get EFS new KMS key settings ##
    efs_kms = flatten( [ for efs, efs_vals in var.efs_file_systems: efs_vals.new_kms_key if efs_vals.encrypted == true && efs_vals.new_kms_key.enabled == true ] )

    ## Get EFS Policy if Enabled ##
    efs_policy = flatten( [ for efs, efs_vals in var.efs_file_systems: {
      file_system_id = aws_efs_file_system.efs[ efs ].id
      module_key = efs_vals.efs_policy.module_key
      efs_policy_local_path = efs_vals.efs_policy.efs_policy_local_path
    } 
    if efs_vals.efs_policy.enabled == true ] )

}

#########################
## Elastic File System ##
#########################
resource "aws_efs_file_system" "efs" {
for_each = var.efs_file_systems

  creation_token = each.value.creation_token
  availability_zone_name = each.value.availability_zone_name == "" ? null : each.value.availability_zone_name
  encrypted = each.value.encrypted
  kms_key_id = each.value.new_kms_key.enabled == true ? aws_kms_key.efs_kms[each.value.new_kms_key.description].id : each.value.kms_key_id
  performance_mode = each.value.performance_mode
  throughput_mode = each.value.throughput_mode
  provisioned_throughput_in_mibps = each.value.throughput_mode == "provisioned" ? each.value.provisioned_throughput_in_mibps : null

  dynamic "lifecycle_policy" {
      for_each = each.value.enable_lifecycle_policy == true ? each.value.lifecycle_policy : {}
      content {
          transition_to_ia = each.value.lifecycle_policy.transition_to_ia
      }
  } 

  tags = each.value.tags
}

## EFS Encryption Key ##
resource "aws_kms_key" "efs_kms" {
for_each = { for o in local.efs_kms: o.description => o}

  description             = each.value.description
  is_enabled = true
  enable_key_rotation = each.value.enable_key_rotation
  deletion_window_in_days = each.value.deletion_window_in_days
  policy = each.value.policy
  
  tags = each.value.kms_tags
}

######################
## EFS Access Point ##
######################
resource "aws_efs_access_point" "efs_access_point" {
for_each = { for o in local.efs_access_point: o.module_key => o }

  file_system_id = each.value.file_system_id

  dynamic "root_directory" {
      for_each = { for o in local.efs_access_point: o.module_key => o if o.root_directory.enabled == true }
      content {
          path = each.value.root_directory.path
          creation_info {
              owner_gid = each.value.root_directory.creation_info.owner_gid
              owner_uid = each.value.root_directory.creation_info.owner_uid
              permissions = each.value.root_directory.creation_info.permissions
          }
      }
  }

  dynamic "posix_user" {
      for_each = { for o in local.efs_access_point: o.module_key => o if o.posix_user.enabled == true }
      content {
          gid = each.value.access_point.posix_user.gid
          secondary_gids = each.value.access_point.posix_user.secondary_gids
          uid = each.value.access_point.posix_user.uid
      }
  }
}

#####################
## EFS Mount Point ##
#####################
resource "aws_efs_mount_target" "efs_mount_target" {
for_each = { for o in local.mount_targets: o.module_key => o }

  file_system_id = each.value.file_system_id
  ip_address = each.value.ip_address
  subnet_id      = each.value.new_subnet.enabled == true ? aws_subnet.efs_subnet[each.value.new_subnet.cidr_block].id : each.value.subnet_id
  security_groups = concat( each.value.new_security_group.enabled == true ? [aws_security_group.efs_security_group[each.value.new_security_group.name].id] : [], each.value.security_groups )
}

## New Subnet for EFS Mount Point ##

resource "aws_subnet" "efs_subnet" {
for_each = { for o in local.mount_target_new_subnet: o.cidr_block => o }

  vpc_id     = each.value.vpc_id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = each.value.subnet_tags
  
}

# New Security Group for EFS Mount Point #
resource "aws_security_group" "efs_security_group" {
for_each = { for o in local.new_security_group: o.name => o }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = toset( [ for val in each.value.ingress_protocol_ports: split(".", val ) ] )
    content {
      description      = each.value.description
      protocol         = ingress.value[0]
      from_port        = ingress.value[1]
      to_port          = ingress.value[2]
      security_groups = each.value.ingress_security_groups
      cidr_blocks      = each.value.ingress_ipv4_cidr_blocks
      ipv6_cidr_blocks = each.value.ingress_ipv6_cidr_blocks
    }
  }

 tags = each.value.security_group_tags
}

################
## EFS Policy ##
################
resource "aws_efs_file_system_policy" "efs_policy" {
for_each = {for o in local.efs_policy: o.module_key => o }

  file_system_id = each.value.file_system_id

  policy =  file(each.value.efs_policy_local_path) 

}