module "ROUTE_TABLE_MODULE" {
source = "../Back_End_Modules/VPC_Route_Tables-Module"

######################
## VPC ROUTE TABLES ##
######################
create_route_tables = true

vpc_id = module.VPC_AWS_PROJECT.vpc_001_id

route_tables = {       
    #---------------------------------------------------#        
    Private_Route_Table_1 = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = "Priv_RT_001_VPC_001"
        ## ASSOCIATED SUBNETS ##
        subnet_ids = []
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
            #---------------------------------------#
            New_NAT_Gateway_0  =  {
                    destination = {
                        ipv4_cidr_block = "0.0.0.0/0"
                    }
                    target = {
                        type = "nat_gateway" 
                        new_target = true 
                        target_values = {
                            nat_gateway_name = "Pub_NATGW_001_VPC_001" 
                            subnet_id = module.VPC_AWS_PROJECT.PubSub_001_VPC_001_id
                    } }   
            }
            #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "Public_Route_Tables_VPC_001" = "Priv_RT_001_VPC_001"
        }
    }
    #---------------------------------------------------#
    #---------------------------------------------------#        
    Private_Route_Table_2 = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = "Priv_RT_002_VPC_001"
        ## ASSOCIATED SUBNETS ##
        subnet_ids = []
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
            #---------------------------------------#
            New_NAT_Gateway_0  =  {
                    destination = {
                        ipv4_cidr_block = "0.0.0.0/0"
                    }
                    target = {
                        type = "nat_gateway" 
                        new_target = true 
                        target_values = {
                            nat_gateway_name = "Pub_NATGW_002_VPC_001" 
                            subnet_id = module.VPC_AWS_PROJECT.PubSub_002_VPC_001_id
                    } }   
            }
            #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "Public_Route_Tables_VPC_001" = "Priv_RT_001_VPC_001"
        }
    }
    #---------------------------------------------------#

###############################################################################################################################################################################################

    #---------------------------------------------------#        
    Database_Route_Table_1 = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = "DB_RT_001_VPC_001"
        ## ASSOCIATED SUBNETS ##
        subnet_ids = []
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
            #---------------------------------------#
            New_NAT_Gateway_0  =  {
                    destination = {
                        ipv4_cidr_block = "0.0.0.0/0"
                    }
                    target = {
                        type = "nat_gateway" 
                        new_target = true 
                        target_values = {
                            nat_gateway_name = "DB_NATGW_001_VPC_001" 
                            subnet_id = module.VPC_AWS_PROJECT.PubSub_001_VPC_001_id
                    } }   
            }
            #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "Database_Route_Tables_VPC_001" = "DB_RT_001_VPC_001"
        }
    }
    #---------------------------------------------------#
    #---------------------------------------------------#        
    Database_Route_Table_2 = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = "DB_RT_002_VPC_001"
        ## ASSOCIATED SUBNETS ##
        subnet_ids = []
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
            #---------------------------------------#
            New_NAT_Gateway_0  =  {
                    destination = {
                        ipv4_cidr_block = "0.0.0.0/0"
                    }
                    target = {
                        type = "nat_gateway" 
                        new_target = true 
                        target_values = {
                            nat_gateway_name = "DB_NATGW_002_VPC_001" 
                            subnet_id = module.VPC_AWS_PROJECT.PubSub_002_VPC_001_id
                    } }   
            }
            #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "Database_Route_Tables_VPC_001" = "DB_RT_002_VPC_001"
        }
    }
    #---------------------------------------------------#
}

###################
## END OF MODULE ##
###################
}

