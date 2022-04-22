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