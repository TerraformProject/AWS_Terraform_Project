module "VPC_ALL_IN_ONE" {
source = ""

#########
## VPC ##
#########

    ## VPC SETTINGS ##
    create_vpc = false
    vpc_name = ""
    cidr_block       = ""
    assign_generated_ipv6_cidr_block = false
    instance_tenancy = ""
    enable_dns_support = false
    enable_dns_hostnames = false
    enable_classiclink = false
    enable_classiclink_dns_support = false
    ## VPC TAGS ##
    vpc_tags = {
        "" = ""
    }
    ## VPC CIDR BLOCK ASSOCIATIONS ##
    associate_cidr_blocks = false
    cidr_blocks_associated = []

##########################
## VPC DHCP OPTIONS SET ##
##########################

    ## VPC DHCP OPTIONS SET SETTINGS ##
    enable_dhcp_options = false
    dhcp_options_set_name = ""
    dhcp_options_domain_name = ""
    dhcp_options_domain_name_servers = [""]
    dhcp_options_ntp_servers = []
    dhcp_options_netbios_name_servers = []
    dhcp_options_netbios_node_type = 0
    ## VPC DHCP OPTIONS SET TAGS ##
    dhcp_options_tags = {
        "" = ""
    }

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

#################
## VPC SUBNETS ##
#################
subnets = {
    #####################################################   
    Example_Subnet = {
        ## VPC SUBNET SETTINGS ##
        subnet_name = ""
        vpc_id = ""
        cidr_block = ""
        availability_zone = ""
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""
        ## VPC SUBNET ASSOCIATIONS ##
        route_table_association = ""
        ## VPC SUBNET TAGS ##
        tags = {
            "" = "",
            }
        }
    #####################################################
}

#######################
## INTERNET GATEWAYS ##
#######################
internet_gateways = {
    #####################################################
    Example_Internet_Gateway = {
        ## INTERNET GATEWAY SETTINGS ##   
        igw_name = ""
        vpc_id = module.VPC_VPC1.vpc.id
        ## INTERNET GATEWAY TAGS ##
        tags = {
            "" = ""
            }
        }
    #####################################################
}

###################################   
## EGRESS-ONLY INTERNET GATEWAYS ##
###################################
egress_internet_gateways = {
    #####################################################
        
    #####################################################
}

##################
## NAT GATEWAYS ##
##################
nat_gateways = {
    #####################################################
    Example_NAT_Gateway = {
        ## NAT GATEWAY SETTINGS ##
        nat_gateway_name = ""
        subnet_id =  ""
        create_new_eip = false
        new_eip_index = 0
        eip_allocation_id = ""
        ## NAT GATEWAY TAGS ##
        tags = { 
            "" = ""
            }
        }
    #####################################################
}

###################    
## VPC ENDPOINTS ##
###################
vpc_endpoints = {
    #####################################################
        
    #####################################################
}

######################
## TRANSIT GATEWAYS ##
######################
transit_gateways = {
    #####################################################
        
    #####################################################
}

#############################
## VPC PEERING CONNECTIONS ##
#############################
vpc_peering_connections = {
    #####################################################
        
    #####################################################
}

###################
## END OF MODULE ##
###################    
}