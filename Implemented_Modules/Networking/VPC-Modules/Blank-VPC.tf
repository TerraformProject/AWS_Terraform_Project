module "VPC_VPC1" {
source = ""

#################
## VPC Config. ##
#################

    create_vpc = false
    vpc_name = ""
    cidr_block       = ""
    assign_generated_ipv6_cidr_block = false
    instance_tenancy = ""
    enable_dns_support = false
    enable_dns_hostnames = false
    enable_classiclink = false
    enable_classiclink_dns_support = false
    
    vpc_tags = {
        "" = ""
    }

################################
## VPC: Associated CIDR Block ##
################################

    associate_cidr_blocks = false
    cidr_blocks_associated = []

##############################
## DHCP Options Set Config. ##
##############################

    enable_dhcp_options = false
    dhcp_options_set_name = ""
    dhcp_options_domain_name = ""
    dhcp_options_domain_name_servers = [""]
    dhcp_options_ntp_servers = []
    dhcp_options_netbios_name_servers = []
    dhcp_options_netbios_node_type = 0

    dhcp_options_tags = {
        "" = ""
    }

##########################
## Default Route Tables ##
##########################

    manage_default_route_table = false
    default_route_table_name = ""
    default_route_table_id = ""
    default_route_table_propagating_vgws = [] 
    default_route_table_routes = {}

    default_route_table_tags = {
        "" = ""
    }

##################
## Route Tables ##
##################

route_tables = {

    ## Public Route Table ## 
            
    #####################################################        
        Route_Table_1 = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = ""
            vpc_id = ""
            propagating_vgws = []
            ## ASSOCIATED ROUTES ##
            associated_routes = {
                Public_Route_1 =  {
                    cidr_block = ""
                    gateway_id     = ""
                    }
            }
            ## ROUTE TABLE TAGS ##
            tags = {
                Public_Route_Table = ""
                }
        }
    #####################################################

}

###################
## TARGET ROUTES ##
###################

       
     ## VPC Peering Connection ##

        vpc_peering_connections = {}

    ## Internet Gateways ##
        
        internet_gateways = {

            Internet_Gateway_1_VPC1 = {
                igw_name = ""

                vpc_id = module.VPC_VPC1.vpc.id

                tags = {
                    "" = ""
                }
            }
        }

        
    ## Egress Only Internet Gateways ##
        
        # assign_generated_ipv6_cidr_block in VPC1 module must = true
        egress_internet_gateways = {}

    ## NAT Gateways ##
        
        nat_gateways = {

            nat_gateway_1 = {
                nat_gateway_name = ""
                subnet_id =  ""
                create_new_eip = false
                new_eip_index = 0
                eip_allocation_id = ""
                
                tags = { "" = "" }
            }

        }

        
    ## VPC Endpoints ##
        
        vpc_endpoints = {}

    ## Transit Gateways ##
        
        transit_gateways = {}

######################
## Declared Subnets ##
######################
subnets = {

    ## Subnets ##
        
        subnet_1 = {
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

            route_table_association = ""

            tags = {
                "" = "",
            }
        }

  
    }
}