#######################################
## Application Load Balancer Outputs ##
#######################################
#--Sample ----------------------------------#
# output "LB_Type_Export_Attribute" {
#   value = aws_lb.load_balancer["lb_type"].export_attribute
# }
#-------------------------------------------#

output "LB_application_id" {
  value = aws_lb.load_balancer["application"].id
}

##########################
## Target Groups Output ##
##########################
#--Sample ----------------------------------#
# output "Target_Group_Index_Key_Export_Attribute" {
#   value = aws_lb_target_group.lb_target_groups["Target_Group_Index_Key"].export_attribute
# }
#-------------------------------------------#

output "target_group_1_arn" {
  value = aws_lb_target_group.lb_target_groups["target_group_1"].arn
}

output "target_group_2_arn" {
  value = aws_lb_target_group.lb_target_groups["target_group_2"].arn
}


###############################################
## Application Load Balancer Security Groups ##
###############################################
#--Sample ----------------------------------#
# output "app_lb_security_group_Export_Attribute" {
#   value = aws_security_group.new_security_groups["app_lb_security_group"].export_attribute <-- Fixed, only specify export attribute
# }
#-------------------------------------------#

output "app_lb_security_group_id" {
  value = aws_security_group.new_security_groups["app_lb_security_group"].id 
}
