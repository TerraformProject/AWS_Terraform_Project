#######################################
## Application Load Balancer Outputs ##
#######################################

output "app_lb" {
  value = aws_lb.load_balancer["application"]
}

###############################################
## Application Load Balancer Security Groups ##
###############################################

output "app_lb_security_group" {
  value = aws_security_group.new_security_groups["lb_001_app_security_group"]
}

##########################
## Target Groups Output ##
##########################

output "target_group_1" {
  value = aws_lb_target_group.lb_target_groups["target_group_1"]
}

output "target_group_2" {
  value = aws_lb_target_group.lb_target_groups["target_group_2"]
}