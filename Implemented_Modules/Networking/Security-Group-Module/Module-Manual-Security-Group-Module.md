# AWS Security Groups   

[AWS Documentation: Security Group Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

[HashiCorp Terraform: Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)   

**Use the below example to create as many security groups as needed.**

```Terraform
#####################
## SECURITY GROUPS ##
#####################
create_new_security_groups = false
new_security_groups = {
# Able to create more than security group
  #-----------------------------------------#
  security_group = {
    ## Security Group Settings ##
    name        = string # Name of security group. If "", Terraform will assign a random unigue name to the security group
    description = string # Description of the security group. If "", Terraform will auto assign the description "Managed by Terraform
    vpc_id      = string # The VPC ID where the security group will be located in 
    ## Ingress Rule Declarations ##
    ingress_rules = { 
    # Able to create more than one ingress rule
          #---------------------------------#
          rule_1 = {
            description      = string # Description of the ingress rule
            from_port        = number # Starting port of the ingress rule
            to_port          = number # Ending port of the ingress rule
            protocol         = string # Protocol for the ingress rule. If "-1" (all), from/to ports must == 0
            cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the ingress rule. If [], then cidr_blocks == null
            ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the ingress rule. If [], then ipv6_cidr_blocks == null  
            self = false  # Whether the security group itself will be added as a source to this ingress rule
          }
          #---------------------------------#
    }
    ## Egress Rule Declarations ##
    egress_rules = {  
    # Able to create more than one egress rule
          #---------------------------------#
          rule_1 = {
            description      = string # Description of the egress rule
            from_port        = number # Starting port of the egress rule
            to_port          = number # Ending port of the egress rule
            protocol         = string # Protocol for the egress rule. If "-1" (all), from/to ports must == 0
            cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the egress rule. If [], then cidr_blocks == null
            ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the egress rule. If [], then ipv6_cidr_blocks == null  
            self = false  # Whether the security group itself will be added as a source to this egress rule
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
```