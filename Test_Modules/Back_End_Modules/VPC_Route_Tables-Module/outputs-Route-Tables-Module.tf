#########################
## Route Table Outputs ##
#########################

#- Sample --------------------------------------#
# output "route_table_module_key_export_attribute" {
#   value = aws_route_table.route_tables["Route_Table_Module_Key"].export_attribute
# }
#-----------------------------------------------#

##########################################
## New Target: Internet Gateway Outputs ##
##########################################

#- Sample --------------------------------------#
# output "internet_gateway_name_export_attribute" {
#   value = aws_internet_gateway.new_target_internet_gateway["Internet_Gateway_Name"].export_attribute
# }
#-----------------------------------------------#

######################################################
## New Target: Egress-Only Internet Gateway Outputs ##
######################################################

#- Sample --------------------------------------#
# output "egress_only_internet_gateway_name_export_attribute" {
#   value = aws_egress_only_internet_gateway.new_target_egress_only_gateway["Egress_Only_Internet_Gateway_Name"].export_attribute
# }
#-----------------------------------------------#

#####################################
## New Target: NAT Gateway Outputs ##
#####################################

#- Sample --------------------------------------#
# output "nat_gateway_name_export_attribute" {
#   value = aws_nat_gateway.new_target_nat_gateway["NAT_Gateway_Name"].export_attribute
# }
#-----------------------------------------------#

#####################################
## New Target: VPC Endpoint Outputs ##
#####################################

#- Sample --------------------------------------#
# output "vpc_endpoint_name_export_attribute" {
#   value = aws_vpc_endpoint.new_target_vpc_endpoint["VPC_Endpoint_Name"].export_attribute
# }
#-----------------------------------------------#

###########################################
## New Target: Network Interface Outputs ##
###########################################

#- Sample --------------------------------------#
# output "network_interface_name_export_attribute" {
#   value = aws_network_interface.new_target_network_interface["Network_Interface_Name"].export_attribute
# }
#-----------------------------------------------#

####################################################
## New Target: Transit Gateway Attachment Outputs ##
####################################################

#- Sample --------------------------------------#
# output "tgw_attachment_name_export_attribute" {
#   value = aws_ec2_transit_gateway_vpc_attachment.new_target_tgw_vpc_attachment["tgw_attachment_Name"].export_attribute
# }
#-----------------------------------------------#

#######################################
## New Target: Local Gateway Outputs ##
#######################################

#- Sample --------------------------------------#
# output "lgw_route_table_id_-_lgw_destination_cidr_block_export_attribute" {
#   value = aws_ec2_transit_gateway_vpc_attachment.new_target_tgw_vpc_attachment["lGW_Route_Table_ID-lGW_Destination_CIDR_Block"].export_attribute
# }
#-----------------------------------------------#

################################################
## New Target: VPC Peering Connection Outputs ##
################################################

#- Sample --------------------------------------#
# output "vpc_connection_name_export_attribute" {
#   value = aws_vpc_peering_connection.new_target_vpc_peering_connection["VPC_Peering_Connection_Name"].export_attribute
# }
#-----------------------------------------------#

