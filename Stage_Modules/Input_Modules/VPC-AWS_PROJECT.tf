module "VPC_AWS_PROJECT" {
source = "../Back_End_Modules/VPC-Module"

##################
## VPC GROUPING ##
############################################################
create_vpc_group = true
vpc_group = {
    #------------------------------------------------------#
    VPC_001 = {
            vpc_name = "VPC_001"
            #- VPC CIDR BLOCKS ----------------------------#
            cidr_block       = "172.16.0.0/16"
            secondary_ipv4_cidr_blocks = ["172.32.0.0/16", "172.48.0.0/16"]
            assign_generated_ipv6_cidr_block = true
            #- DNS SETTINGS -------------------------------#
            enable_dns_support = true
            enable_dns_hostnames = true
            #- GATEWAY/ENDPOINT SETTINGS ------------------#
            internet_gateway_name = "IGW_VPC_001"
            egress_only_internet_gateway_names = [] 
            nat_gateway_names = []
            #- VPC ROUTE TABLE SETTINGS -------------------#
            vpc_default_route_table_name = ""
            vpc_route_tables = {
                #------------------------------------------#
                Public_Route_Table_1 = {
                route_table_name = "Pub_RT_001_VPC_001"
                route_table_tags = { "VPC_001_Route_Tables" = "Pub_RT_001"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                gateway_id = "IGW_VPC_001"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Public_Route_Table_2 = {
                route_table_name = "Pub_RT_002_VPC_001"
                route_table_tags = { "VPC_001_Route_Tables" = "Pub_RT_002"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                gateway_id = "IGW_VPC_001"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
            }
            #- VPC SUBNET SETTINGS ------------------------#
            vpc_subnets = {
                #------------------------------------------#
                Public_Subnet_1 = {
                    subnet_name = "PubSub_001_VPC_001"
                    availability_zone = "us-east-1a"
                    cidr_block = "172.16.5.0/24"
                    ipv6_newbits_netnumb = "8|1"
                    assign_ipv6_address_on_creation = true
                    map_public_ip_on_launch = false
                    route_table_name = "Pub_RT_001_VPC_001"
                    subnet_tags = { "VPC_001_Public_Subnets" = "PubSub_001" }
                }
                #-----------------------------------------#
                #------------------------------------------#
                Public_Subnet_2 = {
                    subnet_name = "PubSub_002_VPC_001"
                    availability_zone = "us-east-1b"
                    cidr_block = "172.16.10.0/24"
                    ipv6_newbits_netnumb = "8|2"
                    assign_ipv6_address_on_creation = true
                    map_public_ip_on_launch = false
                    route_table_name = "Pub_RT_002_VPC_001"
                    subnet_tags = { "VPC_001_Public_Subnets" = "PubSub_002" }
                }
                #-----------------------------------------#
            }
            #- DEFAULT ACL SETTINGS ----------------------#
            default_acl = {
                #-----------------------------------------#
                acl_name = "Default_ACL"
                acl_rules = [
                # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
                ] 
                #-----------------------------------------#
            }
            #- DEFAULT SECURITY GROUP SETTINGS -----------#
            default_security_group = {
                #-----------------------------------------#
                security_group_name = "Default_Security_Group"
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