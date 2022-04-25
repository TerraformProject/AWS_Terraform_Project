################
## VPC OUTPUT ##
################

#- Sample -------------------------------------------#
# output "module_key_export_attribute" {
#   value = aws_vpc.vpc["module_key"].export_attribute
# }
#----------------------------------------------------#

output "vpc_aws_terraform_id" {
  value = aws_vpc.vpc["vpc_aws_terraform"].id
}

output "vpc_aws_terraform_arn" {
  value = aws_vpc.vpc["vpc_aws_terraform"].arn
}

output "vpc_aws_terraform_tags" {
  value = aws_vpc.vpc["vpc_aws_terraform"].tags_all
}

###############################
## VPC IPv4 CIDR Association ##
###############################

#- Sample -------------------------------------------#
# output "module_key_export_attribute" {
#   value = aws_vpc_ipv4_cidr_block_association.this["module_key"].export_attribute
# }
#----------------------------------------------------#

##########################
## VPC Internet Gateway ##
##########################

#- Sample -------------------------------------------#
# output "igw_name_export_attribute" {
#   value = aws_internet_gateway.igw["igw_name"].export_attribute
# }
#----------------------------------------------------#

output "IGW_One_export_id" {
  value = aws_internet_gateway.igw["IGW_One"].id
}

output "IGW_One_export_arn" {
  value = aws_internet_gateway.igw["IGW_One"].arn
}

output "IGW_One_export_tags_all" {
  value = aws_internet_gateway.igw["IGW_One"].tags_all
}

######################################
## VPC Egress Only Internet Gateway ##
######################################

#- Sample -------------------------------------------#
# output "egress_only_igw_name_export_attribute" {
#   value = aws_egress_only_internet_gateway.egress_only_igw["egress_only_igw_name"].export_attribute
# }
#----------------------------------------------------#

#####################
## VPC NAT Gateway ##
#####################

#- Sample -------------------------------------------#
# output "nat_gateway_name_export_attribute" {
#   value = aws_nat_gateway.nat_gateway["nat_gateway_name"].export_attribute
# }
#----------------------------------------------------#

output "NATGW1_export_id" {
  value = aws_nat_gateway.nat_gateway["NATGW1"].id
}

output "NATGW1_export_tags_all" {
  value = aws_nat_gateway.nat_gateway["NATGW1"].tags_all
}

output "NATGW2_export_id" {
  value = aws_nat_gateway.nat_gateway["NATGW2"].id
}

output "NATGW2_export_tags_all" {
  value = aws_nat_gateway.nat_gateway["NATGW2"].tags_all
}

#############################
## VPC Default Route Table ##
#############################

#- Sample -------------------------------------------#
# output "default_route_table_name_export_attribute" {
#   value = aws_default_route_table.default_route_table["default_route_table_name"].export_attribute
# }
#----------------------------------------------------#

output "Route_Table_Default_id" {
  value = aws_default_route_table.default_route_table["Route_Table_Default"].id
}

output "Route_Table_Default_arn" {
  value = aws_default_route_table.default_route_table["Route_Table_Default"].arn
}

output "Route_Table_Default_tags_all" {
  value = aws_default_route_table.default_route_table["Route_Table_Default"].tags_all
}

######################
## VPC Route Tables ##
######################

#- Sample -------------------------------------------#
# output "route_table_name_export_attribute" {
#   value = aws_route_table.route_tables["default_route_table_name"].export_attribute
# }
#----------------------------------------------------#

output "Route_Table_One_id" {
  value = aws_route_table.route_tables["Route_Table_One"].id
}

output "Route_Table_One_arn" {
  value = aws_route_table.route_tables["Route_Table_One"].arn
}

output "Route_Table_One_tags_all" {
  value = aws_route_table.route_tables["Route_Table_One"].tags_all
}

#################
## VPC Subnets ##
#################

#- Sample -------------------------------------------#
# output "subnet_name_export_attribute" {
#   value = aws_subnet.subnets["subnet_name"].export_attribute
# }
#----------------------------------------------------#

output "Subnet_One_id" {
  value = aws_subnet.subnets["Subnet_One"].id
}

output "Subnet_One_arn" {
  value = aws_subnet.subnets["Subnet_One"].arn
}

output "Subnet_One_tags_all" {
  value = aws_subnet.subnets["Subnet_One"].tags_all
}

#####################
## VPC Default ACL ##
#####################

#- Sample -------------------------------------------#
# output "default_acl_name_export_attribute" {
#   value = aws_default_network_acl.default_acl["module_key"].export_attribute
# }
#----------------------------------------------------#

output "Default_ACL_id" {
  value = aws_default_network_acl.default_acl["vpc_aws_terraform"].id
}

output "Default_ACL_arn" {
  value = aws_default_network_acl.default_acl["vpc_aws_terraform"].arn
}

output "Default_ACL_tags_all" {
  value = aws_default_network_acl.default_acl["vpc_aws_terraform"].tags_all
}

################################
## VPC Default Security Group ##
################################

#- Sample -------------------------------------------#
# output "default_security_group_name_export_attribute" {
#   value = aws_default_security_group.default_security_group["module_key"].export_attribute
# }
#----------------------------------------------------#

output "Default_Security_Group_id" {
  value = aws_default_security_group.default_security_group["vpc_aws_terraform"].id
}

output "Default_Security_Group_arn" {
  value = aws_default_security_group.default_security_group["vpc_aws_terraform"].arn
}

output "Default_Security_Group_tags_all" {
  value = aws_default_security_group.default_security_group["vpc_aws_terraform"].tags_all
}