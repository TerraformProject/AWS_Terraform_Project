###########################
## Public subnet Outputs ##
###########################

#- Sample --------------------------------------#
# output "subnet_module_key_export_attribute" {
#   value = aws_subnet.vpc_subnets["Subnet_Module_Key"].export_attribute
# }
#-----------------------------------------------#

output "Database_Subnet_1_id" {
    value = aws_subnet.subnets["Database_Subnet_1"].id
}

output "Database_Subnet_2_id" {
    value = aws_subnet.subnets["Database_Subnet_2"].id
}

output "Database_Subnet_3_id" {
    value = aws_subnet.subnets["Database_Subnet_3"].id
}