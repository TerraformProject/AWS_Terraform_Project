module "VPC_VPC1" {
source = "../../Modules/Network-Modules/Default-modules/VPC-Modules-Default"

#################
## VPC Config. ##
#################

    create_vpc = true
    vpc_name = "VPC1"
    cidr_block       = "192.168.0.0/16"
    assign_generated_ipv6_cidr_block = false
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    enable_classiclink = false
    enable_classiclink_dns_support = false
    
    vpc_tags = {
        "VPC" = "VPC_VPC1"
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
    dhcp_options_set_name = "DHCP_VPC1"
    dhcp_options_domain_name = "nutsandboltz.com"
    dhcp_options_domain_name_servers = ["192.168.0.2"]
    dhcp_options_ntp_servers = []
    dhcp_options_netbios_name_servers = []
    dhcp_options_netbios_node_type = 2

    dhcp_options_tags = {
        "DHCP" = "DHCP_VPC1"
    }

##########################
## Default Route Tables ##
##########################

    manage_default_route_table = true
    default_route_table_name = "Default_Route_Table"
    default_route_table_id = module.VPC_VPC1.vpc_default_route_table_id
    default_route_table_propagating_vgws = [] 
    default_route_table_routes = {}

    default_route_table_tags = {
        "Default_Route_Table" = "Default_Route_Table_VPC1"
    }

##################
## Route Tables ##
##################

route_tables = {

    ## Public Route Table ## 
            
        Public_Route_Table_1 = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = "Public_Route_Table_1"
            vpc_id = module.VPC_VPC1.vpc.id
            propagating_vgws = []

            ## ASSOCIATED ROUTES ##
            associated_routes = {
                Public_Route_1 =  {
                    cidr_block = "0.0.0.0/0"
                    gateway_id     = "Internet_Gateway_1_VPC1"
                    }
            }

            ## ROUTE TABLE TAGS ##
            tags = {
                Public_Route_Table = "Public_Route_Table_1"
                }
        }

        Public_Route_Table_2 = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = "Public_Route_Table_2"
            vpc_id = module.VPC_VPC1.vpc.id
            propagating_vgws = []

            ## ASSOCIATED ROUTES ##
            associated_routes = {
                Public_Route_1 =  {
                    cidr_block = "0.0.0.0/0"
                    gateway_id     = "Internet_Gateway_1_VPC1"
                    }
            }

            ## ROUTE TABLE TAGS ##
            tags = {
                Public_Route_Table = "Public_Route_Table_2"
                }
        }

    ## Private Route Tables ##

        Private_Route_Table_1 = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = "Private_Route_Table_1"
            vpc_id = module.VPC_VPC1.vpc.id
            propagating_vgws = []

            ## ASSOCIATED ROUTES ##
            associated_routes = {
                Private_Route_1 =  {
                    cidr_block = "0.0.0.0/0"
                    nat_gateway_id = "nat_gateway_1"
                    }
                }

            ## ROUTE TABLE TAGS ##
            tags = {
                Public_Route_Table = "Private_Route_Table_1"
                }
        }

        Private_Route_Table_2 = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = "Private_Route_Table_2"
            vpc_id = module.VPC_VPC1.vpc.id
            propagating_vgws = []

            ## ASSOCIATED ROUTES ##
            associated_routes = {
                Private_Route_1 =  {
                    cidr_block = "0.0.0.0/0"
                    nat_gateway_id = "nat_gateway_1"
                    }
                }

            ## ROUTE TABLE TAGS ##
            tags = {
                Public_Route_Table = "Private_Route_Table_2"
                }
        }

        
    ## Database Route Tables ##

        Database_Route_Table_1 = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = "Database_Route_Table_1"
            vpc_id = module.VPC_VPC1.vpc.id
            propagating_vgws = []

            ## ASSOCIATED ROUTES ##
            associated_routes = {}

            ## ROUTE TABLE TAGS ##
            tags = {
                Database_Route_Table = "Database_Route_Table_1"
                }
        }

        Database_Route_Table_2 = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = "Database_Route_Table_2"
            vpc_id = module.VPC_VPC1.vpc.id
            propagating_vgws = []
            ## ASSOCIATED ROUTES ##
            associated_routes = {}

            ## ROUTE TABLE TAGS ##
            tags = {
                Database_Route_Table = "Database_Route_Table_2"
                }
        }

        Database_Route_Table_3 = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = "Database_Route_Table_3"
            vpc_id = module.VPC_VPC1.vpc.id
            propagating_vgws = []

            ## ASSOCIATED ROUTES ##
            associated_routes = {}

            ## ROUTE TABLE TAGS ##
            tags = {
                Database_Route_Table = "Database_Route_Table_3"
                }
        }
}

###################
## TARGET ROUTES ##
###################

       
     ## VPC Peering Connection ##

        vpc_peering_connections = {}

    ## Internet Gateways ##
        
        internet_gateways = {

            Internet_Gateway_1_VPC1 = {
                igw_name = "IGW_1_VPC1"

                vpc_id = module.VPC_VPC1.vpc.id

                tags = {
                    "Internet_Gateways" = "IGW_1_VPC1"
                }
            }
        }

        
    ## Egress Only Internet Gateways ##
        
        # assign_generated_ipv6_cidr_block in VPC1 module must = true
        egress_internet_gateways = {}

    ## NAT Gateways ##
        
        nat_gateways = {

            nat_gateway_1 = {
                nat_gateway_name = "nat_gateway_1_VPC1"
                subnet_id =  "public_subnet_1"
                create_new_eip = true
                new_eip_index = 0
                eip_allocation_id = ""
                
                tags = { "internet_gateways" = "internet_gateway_1_VPC1" }
                }

            nat_gateway_2 = {
                nat_gateway_name = "nat_gateway_2_VPC1"
                subnet_id =  "public_subnet_2"
                create_new_eip = true
                new_eip_index = 1
                eip_allocation_id = ""

                tags = { "internet_gateways" = "internet_gateway_2_VPC1" }
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

    ## Public Subnets ##
        
        public_subnet_1 = {
            subnet_name = "public_subnet_1"
            vpc_id = module.VPC_VPC1.vpc.id
            cidr_block = "192.168.1.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""

            route_table_association = "Public_Route_Table_1"

            tags = {
                "Public_Subnet" = "Public_Subnet_1",
            }
        }

        public_subnet_2 = {
            subnet_name = "public_subnet_2"
            vpc_id = module.VPC_VPC1.vpc.id
            cidr_block = "192.168.2.0/24"
            availability_zone = "us-east-1b"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""

            route_table_association = "Public_Route_Table_2"

            tags = {
                "Public_Subnet" = "Public_Subnet_2",
            }
        }

     
    ## Private Subnets ##
    
        private_subnet_1 = {
            subnet_name = "private_subnet_1"
            vpc_id = module.VPC_VPC1.vpc.id
            cidr_block = "192.168.3.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""

            route_table_association = "Private_Route_Table_1"

            tags = {
                "Private_Subnet" = "Private_Subnet_1",
            }
        }

        private_subnet_2 = {
            subnet_name = "private_subnet_2"
            vpc_id = module.VPC_VPC1.vpc.id
            cidr_block = "192.168.4.0/24"
            availability_zone = "us-east-1b"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""

            route_table_association = "Private_Route_Table_2"

            tags = {
                "Private_Subnet" = "Private_Subnet_2",
            }
        }

    ## Database Subnets ##

        database_subnet_1 = {
            subnet_name = "database_subnet_1"
            vpc_id = module.VPC_VPC1.vpc.id
            cidr_block = "192.168.5.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""

            route_table_association = "Database_Route_Table_1"

            tags = {
                "Database_Subnet" = "Database_Subnet_1",
            }
        }

        database_subnet_2 = {
            subnet_name = "database_subnet_2"
            vpc_id = module.VPC_VPC1.vpc.id
            cidr_block = "192.168.6.0/24"
            availability_zone = "us-east-1b"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""

            route_table_association = "Database_Route_Table_2"

            tags = {
                "Database_Subnet" = "Database_Subnet_2",
            }
        }

        database_subnet_3 = {
            subnet_name = "database_subnet_3"
            vpc_id = module.VPC_VPC1.vpc.id
            cidr_block = "192.168.7.0/24"
            availability_zone = "us-east-1c"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""

            route_table_association = "Database_Route_Table_3"

            tags = {
                "Database_Subnet" = "Database_Subnet_3",
            }
        }
  
    }
}