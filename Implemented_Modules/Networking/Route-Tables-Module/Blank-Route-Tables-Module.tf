module "VPC_ROUTE_TABLES_EXAMPLE" {
source = ""

#############################
## VPC DEFAULT ROUTE TABLE ##
#############################

    ## VPC DEFAULT ROUTE TABLE SETTINGS ##
    manage_default_route_table = false
    default_route_table_name = ""
    default_route_table_id = ""
    default_route_table_propagating_vgws = [] 
    default_route_table_routes = {}
    ## VPC DEFAULT ROUTE TABLE TAGS ##
    default_route_table_tags = {
        "" = ""
    }

######################
## VPC ROUTE TABLES ##
######################
route_tables = {       
    #####################################################        
    Example_Route_Table = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = ""
        vpc_id = ""
        propagating_vgws = []
        ## ASSOCIATED ROUTES ##
        associated_routes = {
            Example_Route_1 =  {
                cidr_block = ""
                gateway_id     = ""
            }
        }
        ## ROUTE TABLE TAGS ##
        tags = {
            Example_Route_Table = ""
        }
    }
    #####################################################
}

###################
## END OF MODULE ##
###################
}