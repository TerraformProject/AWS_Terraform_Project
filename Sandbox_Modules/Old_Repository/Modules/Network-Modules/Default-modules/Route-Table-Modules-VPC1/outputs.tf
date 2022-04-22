#################################
## Default route table Outputs ##
#################################

output "aws_default_route_table_default" {
    value = aws_default_route_table.default[0]
}

#################################
## Public route table Outputs ##
#################################

output "aws_route_table_public" {
    value = aws_route_table.public[*]
}

#################################
## Private route table Outputs ##
#################################

output "aws_route_table_private" {
    value = aws_route_table.private[*]
}

##################################
## Database route table Outputs ##
##################################

output "aws_route_table_database" {
    value = aws_route_table.database[*]
}