################
## VPC OUTPUT ##
################

#- Sample -------------------------------------------#
# output "module_key_export_attribute" {
#   value = aws_vpc.vpc["module_key"].export_attribute
# }
#----------------------------------------------------#

output "vpc_001_id" {
  value = aws_vpc.vpc["VPC_001"].id
}

output "vpc_001_arn" {
  value = aws_vpc.vpc["VPC_001"].arn
}

output "vpc_001_tags" {
  value = aws_vpc.vpc["VPC_001"].tags_all
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
  value = aws_internet_gateway.igw["IGW_VPC_001"].id
}

output "IGW_One_export_arn" {
  value = aws_internet_gateway.igw["IGW_VPC_001"].arn
}

output "IGW_One_export_tags_all" {
  value = aws_internet_gateway.igw["IGW_VPC_001"].tags_all
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

#############################
## VPC Default Route Table ##
#############################

#- Sample -------------------------------------------#
# output "default_route_table_name_export_attribute" {
#   value = aws_default_route_table.default_route_table["default_route_table_name"].export_attribute
# }
#----------------------------------------------------#

######################
## VPC Route Tables ##
######################

#- Sample -------------------------------------------#
# output "route_table_name_export_attribute" {
#   value = aws_route_table.route_tables["default_route_table_name"].export_attribute
# }
#----------------------------------------------------#

## Public Route Table 1

output "Pub_RT_001_VPC_001_id" {
  value = aws_route_table.route_tables["Pub_RT_001_VPC_001"].id
}

output "Pub_RT_001_VPC_001_arn" {
  value = aws_route_table.route_tables["Pub_RT_001_VPC_001"].arn
}

output "Pub_RT_001_VPC_001_tags_all" {
  value = aws_route_table.route_tables["Pub_RT_001_VPC_001"].tags_all
}

## Public Route Table 2

output "Pub_RT_002_VPC_001_id" {
  value = aws_route_table.route_tables["Pub_RT_002_VPC_001"].id
}

output "Pub_RT_002_VPC_001_arn" {
  value = aws_route_table.route_tables["Pub_RT_002_VPC_001"].arn
}

output "Pub_RT_002_VPC_001_tags_all" {
  value = aws_route_table.route_tables["Pub_RT_002_VPC_001"].tags_all
}

#################
## VPC Subnets ##
#################

#- Sample -------------------------------------------#
# output "subnet_name_export_attribute" {
#   value = aws_subnet.subnets["subnet_name"].export_attribute
# }
#----------------------------------------------------#

## Public Subnet 1

output "PubSub_001_VPC_001_id" {
  value = aws_subnet.subnets["PubSub_001_VPC_001"].id
}

output "PubSub_001_VPC_001_arn" {
  value = aws_subnet.subnets["PubSub_001_VPC_001"].arn
}

output "PubSub_001_VPC_001_tags_all" {
  value = aws_subnet.subnets["PubSub_001_VPC_001"].tags_all
}

## Public Subnet 2

output "PubSub_002_VPC_001_id" {
  value = aws_subnet.subnets["PubSub_002_VPC_001"].id
}

output "PubSub_002_VPC_001_arn" {
  value = aws_subnet.subnets["PubSub_002_VPC_001"].arn
}

output "PubSub_002_VPC_001_tags_all" {
  value = aws_subnet.subnets["PubSub_002_VPC_001"].tags_all
}

#####################
## VPC Default ACL ##
#####################

#- Sample -------------------------------------------#
# output "vpc_module_key_default_acl_export_attribute" {
#   value = aws_default_network_acl.default_acl["VPC_Module_Key"].export_attribute
# }
#----------------------------------------------------#

output "VPC_001_Default_ACL_id" {
  value = aws_default_network_acl.default_acl["VPC_001"].id
}

output "VPC_001_Default_ACL_arn" {
  value = aws_default_network_acl.default_acl["VPC_001"].arn
}

output "VPC_001_Default_ACL_tags_all" {
  value = aws_default_network_acl.default_acl["VPC_001"].tags_all
}

################################
## VPC Default Security Group ##
################################

#- Sample -------------------------------------------#
# output "vpc_module_key_default_security_group_name_export_attribute" {
#   value = aws_default_security_group.default_security_group["VPC_Module_Key"].export_attribute
# }
#----------------------------------------------------#

output "VPC_001_Default_Security_Group_id" {
  value = aws_default_security_group.default_security_group["VPC_001"].id
}

output "VPC_001_Default_Security_Group_arn" {
  value = aws_default_security_group.default_security_group["VPC_001"].arn
}

output "VPC_001_Default_Security_Group_tags_all" {
  value = aws_default_security_group.default_security_group["VPC_001"].tags_all
}