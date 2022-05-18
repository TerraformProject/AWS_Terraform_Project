# VPC_ACL_Subnet Module Manual

**Use the example below to create as many Network ACLs and Subnet Associations for the desired VPC.**

[AWS Documentation: Network ACL Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html?msclkid=d861274dcfcf11ecbf645c5f738e5b50)

[HashiCorp Terraform Documentation: Network ACL Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl?msclkid=24123822cfcf11eca42fea7bed795d7e)  


```Terraform
#################
## Network ACL ##
#################
create_new_acls = false # Whether or not create new ACLs

vpc_id = "" # The VPC ID to assign the ACLs to

acl_group = {
    #------------------------------------------#
# ABLE TO CREATE MORE THAN ONE #
    Example_ACL_Subnet = { <- If creating more than one ACL, index key must be unique
        ## ACL SETTINGS ##
        acl_name = "" # Name of the acl to merge with ACL tags
        subnet_ids = [] # List of Subent IDs to associate with the ACL
        subnet_tags = {} # List of Subnet Tags to associate with the ACL
        ## INGRESS RULE DECLARATIONS ##
        acl_ingress_rules = { 
        # Able to create more than one #
            #----------------------------------#
            example_ingress_rule = { <- If creating more than one ACL, index key must be unique
                action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                cidr_block = string # Location from where the traffic is coming from
                ipv6_cidr_block = null # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                protocol = "" # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                from_port = 0 # Starting port
                to_port = 0 # Ending Port
                icmp_code = null # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                icmp_type = null # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                rule_no = 0 # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
            }
            #----------------------------------#
        }
        ## EGRESS RULE DECLARATIONS ##
        acl_egress_rules = {
            #----------------------------------#
            example_egress_rule = {
                action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                cidr_block = string # Location from where the traffic is coming from
                ipv6_cidr_block = null # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                protocol = "" # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                from_port = 0 # Starting port
                to_port = 0 # Ending Port
                icmp_code = null # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                icmp_type = null # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                rule_no = 0 # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
            }
            #----------------------------------#
        }
        ## ACL TAGS ##
        tags = {
            "" = "" # The tags to associate with the ACL
        }   }
    #------------------------------------------#
}

###################
## END OF MODULE ##
###################
}
```