#################################
## Default route table Outputs ##
#################################

output "default_route_table_name" {
    value = aws_default_route_table.default_route_table_name
}

output "default_route_table_id" {
    value = aws_default_route_table.default_route_table_id
}

#################################
## Public route table Outputs ##
#################################

output "Public_Route_Table_1" {
    value = aws_route_table.route_tables["Example_Route_Table"]
}