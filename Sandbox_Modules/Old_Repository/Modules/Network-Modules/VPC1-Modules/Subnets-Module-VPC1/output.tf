################################
## Availability Zones Outputs ##
################################

output "aws_availability_zones_available_names" {
    value = data.aws_availability_zones.available.names
}

output "aws_availability_zones_available_zone_ids" {
    value = data.aws_availability_zones.available.zone_ids
}

###########################
## Public subnet Outputs ##
###########################

output "aws_subnet_public_subnets_subnet1" {
    value = aws_subnet.public_subnets["subnet1"]
}

output "aws_subnet_public_subnets_subnet2" {
    value = aws_subnet.public_subnets["subnet2"]
}

output "aws_subnet_public_subnets_tags" {
    value = aws_subnet.public_subnets[*]
}

############################
## Private subnet Outputs ##
############################

output "aws_subnet_private_subnets_subnet1" {
    value = aws_subnet.private_subnets["subnet1"]
}

output "aws_subnet_private_subnets_subnet2" {
    value = aws_subnet.private_subnets["subnet2"]
}

output "aws_subnet_private_subnets_tags" {
    value = aws_subnet.private_subnets[*]
}

#############################
## Database subnet Outputs ##
#############################

output "aws_subnet_database_subnets_subnet1" {
    value = aws_subnet.database_subnets["subnet1"]
}

output "aws_subnet_database_subnets_subnet2" {
    value = aws_subnet.database_subnets["subnet2"]
}

output "aws_subnet_database_subnets_subnet3" {
    value = aws_subnet.database_subnets["subnet3"]
}

output "aws_subnet_database_subnets_tags" {
    value = aws_subnet.database_subnets[*]
}
