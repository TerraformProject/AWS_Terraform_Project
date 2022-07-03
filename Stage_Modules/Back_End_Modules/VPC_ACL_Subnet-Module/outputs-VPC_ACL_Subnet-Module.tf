###############################
## VPC1: Public NACl Outputs ##
###############################

#- Sample ------------------------#
# output "ACL_Subnet_Module_Key_Export_Attribute" {
#   value = aws_network_acl.public_acls["ACL_Subnet_Module_Key"].Attribute
# }
#- Sample ------------------------#

output "Public_Subnet_001_ACL_id" {
  value = aws_network_acl.acl_group["Public_Subnet_001_ACL"].id
}
