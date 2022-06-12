module "SECURITY_GROUP_AWS_PROJECT" {
source = "../Back_End_Modules/Security_Group-Module"

#####################
## SECURITY GROUPS ##
#####################
create_new_security_groups = false
new_security_groups = {
  #-----------------------------------------#
  security_group = {
    ## Security Group Settings ##
    name        = ""
    description = "" 
    vpc_id      = "" 
    ## Ingress Rule Declarations ##
    ingress_rules = { 
          #---------------------------------#
          rule_1 = {
            description      = "" 
            from_port        = 0 
            to_port          = 0 
            protocol         = "" 
            cidr_blocks      = [] 
            ipv6_cidr_blocks = []   
            self = false  
          }
          #---------------------------------#
    }
    ## Egress Rule Declarations ##
    egress_rules = {  
          #---------------------------------#
          rule_1 = {
            description      = "" 
            from_port        = 0 
            to_port          = 0 
            protocol         = "" 
            cidr_blocks      = [] 
            ipv6_cidr_blocks = []   
            self = false 
            }
          #---------------------------------#
    }
    ## Security Group Tags ##
    tags = {
        "" = "" # Tags to associate with security group
      }}
  #-----------------------------------------#
}
########################################################




###################
## END OF MODULE ##
###################
}