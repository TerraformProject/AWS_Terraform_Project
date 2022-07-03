#######################################
## Launch Template Outputs ##
#######################################
#--Sample ----------------------------------#
# output "Launch_Template_Export_Attribute" {
#   value = aws_launch_template.new_ec2_launch_template["lt_values"].export_attribute
# }
#-------------------------------------------#

output "Launch_Template_ID" {
  value = aws_launch_template.new_ec2_launch_template["lt_values"].id
}

output "Launch_Template_ARN" {
  value = aws_launch_template.new_ec2_launch_template["lt_values"].arn
}

output "Launch_Template_Latest_Version" {
  value = aws_launch_template.new_ec2_launch_template["lt_values"].latest_version
}

################################
## ENI Security Group Outputs ##
################################
#--Sample ----------------------------------#
# output "Launch_Template_Security_Group_Index_Key_Export_Attribute" {
#   value = aws_security_group.lt_create_security_group["Security_Group_Index_Key"].export_attribute
# }
#-------------------------------------------#

output "Launch_Template_create_secgrp_000_id" {
  value = aws_security_group.lt_create_security_group["create_secgrp_000"].id
}

output "Launch_Template_create_secgrp_000_arn" {
  value = aws_security_group.lt_create_security_group["create_secgrp_000"].arn
}