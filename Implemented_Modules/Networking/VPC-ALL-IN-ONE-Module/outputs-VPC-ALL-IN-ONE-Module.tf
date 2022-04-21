#################
## VPC Outputs ##
#################

output "vpc" {
    value = aws_vpc.vpc[0]
}

output "vpc_default_route_table_id" {
    value = aws_vpc.vpc[0].default_route_table_id
}

output "vpc_tags" {
    value = aws_vpc.vpc[0].tags
}

output "enable_ipv6" {
    value = aws_vpc.vpc[0].assign_generated_ipv6_cidr_block
}

##############################
## DHCP Options Set Outputs ##
##############################

output "dhcp_options_domain_name" {
    value = var.enable_dhcp_options == true ? aws_vpc_dhcp_options.this[0].domain_name : null
}

##############################
## Internet Gateway Outputs ##
##############################

output "Internet_Gateway_1_VPC1" {
    value = aws_internet_gateway.this["Internet_Gateway_1_VPC1"]
}

##########################################
## Egress Only Internet Gateway Outputs ##
##########################################

# output "Egress_Only_Internet_Gateway_1_VPC1" {
#     value = aws_egress_only_internet_gateway.this["Egress_Only_Internet_Gateway_1_VPC1"]
# }

#########################
## NAT Gateway Outputs ##
#########################

output "nat_gateway" {
    value = aws_nat_gateway.nat_gateway[*]
}

#############################
## New EIP for NAT GATEWAY ##
#############################

# output "eip_nat_gateway_index" {
#     value = aws_eip.nat_gateway_eip[*].id
# }

#################################
## Default route table Outputs ##
#################################

output "aws_default_route_table_default" {
    value = aws_default_route_table.default
}

#################################
## Public route table Outputs ##
#################################

output "Public_Route_Table_1" {
    value = aws_route_table.route_tables["Public_Route_Table_1"]
}

output "Public_Route_Table_2" {
    value = aws_route_table.route_tables["Public_Route_Table_2"]
}

#################################
## Private route table Outputs ##
#################################

output "Private_Route_Table_1" {
    value = aws_route_table.route_tables["Private_Route_Table_1"]
}

output "Private_Route_Table_2" {
    value = aws_route_table.route_tables["Private_Route_Table_2"]
}

##################################
## Database route table Outputs ##
##################################

output "Database_Route_Table_1" {
    value = aws_route_table.route_tables["Database_Route_Table_1"]
}

output "Database_Route_Table_2" {
    value = aws_route_table.route_tables["Database_Route_Table_2"]
}

output "Database_Route_Table_3" {
    value = aws_route_table.route_tables["Database_Route_Table_3"]
}

output "Route_Tables" {
    value = aws_route_table.route_tables[*]
}

###########################
## Public subnet Outputs ##
###########################

output "public_subnet_1" {
    value = aws_subnet.subnets["public_subnet_1"]
}

output "public_subnet_2" {
    value = aws_subnet.subnets["public_subnet_2"]
}

############################
## Private subnet Outputs ##
############################

output "private_subnet_1" {
    value = aws_subnet.subnets["private_subnet_1"]
}

output "private_subnet_2" {
    value = aws_subnet.subnets["private_subnet_2"]
}

#############################
## Database subnet Outputs ##
#############################

output "database_subnet_1" {
    value = aws_subnet.subnets["database_subnet_1"]
}

output "database_subnet_2" {
    value = aws_subnet.subnets["database_subnet_2"]
}

output "database_subnet_3" {
    value = aws_subnet.subnets["database_subnet_3"]
}

#########################
## Hosted Zone Outputs ##
#########################

output "Hosted_Zone_Zone_1" {
  description = "Zone of Route53 zone"
  value       = aws_route53_zone.this["Zone1"]
}

############################
## Route53 Record Outputs ##
############################

output "Hosted_Zone_Records" {
  description = "Records of Route53 zone"
  value       = aws_route53_record.this[*]
}

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


