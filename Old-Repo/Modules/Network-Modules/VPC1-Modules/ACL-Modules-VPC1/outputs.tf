################################
## VPC1: Default NACl Outputs ##
################################

output "VPC1_default_acl" {
  value = aws_default_network_acl.default_acl["acl1"]
}

###############################
## VPC1: Public NACl Outputs ##
###############################

output "VPC1_public_acl" {
  value = aws_network_acl.public_acl["acl1"]
}

################################
## VPC1: Private NACl Outputs ##
################################

output "VPC1_private_acl" {
  value = aws_network_acl.private_acl["acl1"]
}

#################################
## VPC1: Database NACl Outputs ##
#################################

output "VPC1_database_acl" {
  value = aws_network_acl.database_acl["acl1"]
}
