################################
## VPC1: Default NACl Outputs ##
################################

output "Default_Network_ACL" {
  value = aws_default_network_acl.default_acl["Default_Network_ACL"]
}

###############################
## VPC1: Public NACl Outputs ##
###############################

output "Public_Network_ACL_1" {
  value = aws_network_acl.public_acls["Public_Network_ACL_1"]
}