#################################
## Elastic File System Outputs ##
#################################

output "EFS_1" {
    value = aws_efs_file_system.efs["efs_1"]
}

##############################
## EFS Access Point Outputs ##
##############################

output "EFS_1_Access_Point" {
    value = aws_efs_access_point.efs_access_point["EFS_1_Access_Point"]
}

#############################
## EFS Mount Point Outputs ##
#############################

output "EFS_1_Target_1" {
    value = aws_efs_mount_target.efs_mount_target["mount_target_001"]
}

output "EFS_1_Target_2" {
    value = aws_efs_mount_target.efs_mount_target["mount_target_002"]
}

########################
## EFS Policy Outputs ##
########################

output "EFS_1_Policy" {
    value = aws_efs_file_system_policy.efs_policy["Wordress_EFS_Policy_001"]
}
