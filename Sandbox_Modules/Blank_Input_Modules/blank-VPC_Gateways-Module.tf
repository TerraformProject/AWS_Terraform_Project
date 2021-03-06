module "VPC_GATEWAYS_AWS_PROJECT" {
source = "../Back_End_Modules/VPC_Gateways-Module"

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
  
