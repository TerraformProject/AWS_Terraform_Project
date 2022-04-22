##############################
## Internet Gateway Outputs ##
##############################

output "internet_gateway_igw1" {
    value = aws_internet_gateway.this["igw1"]
}

##########################################
## Egress Only Internet Gateway Outputs ##
##########################################

output "egress_internet_gateway_igw1" {
    value = aws_egress_only_internet_gateway.this["egress_gw1"]
}

##################
## NAT Gateway Outputs ##
##################

output "nat_gateway_id_useast1a" {
    value = aws_nat_gateway.nat_gateway["natGW-usEast1a"]

    depends_on = [aws_nat_gateway.nat_gateway]
}

output "nat_gateway_id_useast1b" {
    value = aws_nat_gateway.nat_gateway["natGW-usEast1b"]

    depends_on = [aws_nat_gateway.nat_gateway]
}