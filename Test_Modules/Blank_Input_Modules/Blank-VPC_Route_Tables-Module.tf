module "BLANK_ROUTE_TABLE" {
source = ""

######################
## VPC ROUTE TABLES ##
######################
create_route_tables = false

vpc_id = ""

route_tables = {       
    #####################################################        
    Example_Route_Table = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = ""
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
            #-------------------------------------------#
            Route_1 =  {
                        destination = {
                            cidr_block = ""
                        }
                        target = {
                            new_target = false
                            target_values = {}
                        }   
            }
            #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "" = ""
        }
    }
    #####################################################
}

###################
## END OF MODULE ##
###################
}