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

################################
## VPC1: Private NACl Outputs ##
################################

output "Private_Network_ACL_1" {
  value = aws_network_acl.private_acls["Private_Network_ACL_1"]
}

#################################
## VPC1: Database NACl Outputs ##
#################################

output "Database_Network_ACL_1" {
  value = aws_network_acl.database_acls["Database_Network_ACL_1"]
}
