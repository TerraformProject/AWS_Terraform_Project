########################
## ECS Cluster Output ##
########################

output "ecs_cluster" {
  value = aws_ecs_cluster.new_ecs_cluster["settings"]
}

###############################
## Capacity Providers Output ##
###############################

output "capacity_provider_001" {
  value = aws_ecs_capacity_provider.new_capacity_providers["capacity_provider_001"]
}

output "capacity_provider_002" {
  value = aws_ecs_capacity_provider.new_capacity_providers["capacity_provider_002"]
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

################################
## Auto SCaling Group Outputs ##
################################

output "asg_001" {
  value = aws_autoscaling_group.this["asg_001"]
}

output "asg_002" {
  value = aws_autoscaling_group.this["asg_002"]
}