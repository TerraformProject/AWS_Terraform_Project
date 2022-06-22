module "Blank_VPC_QUICKSTART" {
source = ""

##################
## VPC GROUPING ##
############################################################
create_vpc_group = false
vpc_group = {
    #------------------------------------------------------#
    vpc_aws_terraform = {
            vpc_name = ""
            #- VPC CIDR BLOCKS ----------------------------#
            cidr_block       = ""
            secondary_ipv4_cidr_blocks = []
            assign_generated_ipv6_cidr_block = false
            #- DNS SETTINGS -------------------------------#
            enable_dns_support = false
            enable_dns_hostnames = false
            #- GATEWAY/ENDPOINT SETTINGS ------------------#
            internet_gateway_name = ""
            egress_only_internet_gateway_names = [] 
            nat_gateway_names = []
            #- VPC ROUTE TABLE SETTINGS -------------------#
            vpc_default_route_table_name = ""
            vpc_route_tables = {
                #------------------------------------------#
                Example_Route_Table = {
                route_table_name = ""
                associated_routes = {
                            #------------------------------#
                            Route_1 = {}
                            #------------------------------#
                }   }
                #------------------------------------------#
            }
            #- VPC SUBNET SETTINGS ------------------------#
            vpc_subnets = {
                #------------------------------------------#
                Example_Subnet = {
                    subnet_name = ""
                    availability_zone = ""
                    cidr_block = ""
                    ipv6_cidr_block = ""
                    assign_ipv6_address_on_creation = false
                    map_public_ip_on_launch = false
                    route_table_name = ""
                }
                #-----------------------------------------#
            }
            #- DEFAULT ACL SETTINGS ----------------------#
            default_acl = {
                #-----------------------------------------#
                acl_name = ""
                acl_rules = [
                # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
                ] 
                #-----------------------------------------#
            }
            #- DEFAULT SECURITY GROUP SETTINGS -----------#
            default_security_group = {
                #-----------------------------------------#
                security_group_name = ""
                security_group_rules = [
                # "Direction|Type|Type_Value|Protocol|FromPort|ToPort|RuleName"
                ]
                #-----------------------------------------#
            }
        }
    #-----------------------------------------------------#      
}
###########################################################


###################
## END OF MODULE ##
###################
}