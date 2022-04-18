# AWS Network ACLs

### Default Network ACL 

**Use the example below to create a default network ACL for the associated VPC.**

[AWS Documentation: Default Network ACL Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#custom-network-acl)

[HashiCorp Terraform Documentation: Default Network ACL Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl)

```terraform
##################
## ACL: Default ##
##################
create_default_network_acl = bool # Whether or not to create a default network ACL for the associated VPC
default_network_acl = {

    Default_Network_ACL = {
        ## DEFAULT ACL SETTINGS ##
        default_network_acl_name = string # Name of default ACL to be merged with tags below
        default_network_acl_id = string # ID of default_network_acl attribute exported from the VPC resource 
        default_acl_subnet_ids = list(string) # One or more subnets to associate with the default network ACL
        ## INGRESS RULE DECLARATIONS ##
        default_network_acl_ingress = { # Mapping of objects for the ingress rules to associate with default network ACL
            ####################################
                ingress_rule_1 = { # Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                    action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                    cidr_block = string # Location from where the traffic is coming from
                    from_port = number # Starting port
                    icmp_code       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                    icmp_type       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                    ipv6_cidr_block = string # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                    protocol = string || -1 # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                    rule_no = number # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                    to_port = number # Ending port
                }
            ####################################
        }
        ## INGRESS RULE DECLARATIONS ##
        default_network_acl_egress = { # Mapping of objects for the egress rules to associate with default network ACL
            ####################################
                egress_rule_1 = { # Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                    action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                    cidr_block = string # Location from where the traffic is coming from
                    from_port = number # Starting port
                    icmp_code       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                    icmp_type       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                    ipv6_cidr_block = string # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                    protocol = string || -1 # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                    rule_no = number # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                    to_port = number # Ending port
                }
            ####################################
        }
        ## DEFAULT ACL SETTINGS ##
        tags = {
            "key" = "value" # Tags to associate with the default ACL
        }
    }
}
```

### Network ACl 

**Use the example below to create as many Network ACLs for the desired VPCs.**

[AWS Documentation: Default Network ACL Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#custom-network-acl)

[HashiCorp Terraform Documentation: Default Network ACL Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl)

```terrafrom
########################
## ACL GROUP: EXAMPLE ##
########################
acl_group = {

    Example_ACL = {
        ## ACL SETTINGS ##
        acl_name = string # Name of ACL to be merged with tags below
        vpc_id = string # ID of VPC for the Network ACL to reside in
        acl_subnet_ids = list(string) # One or more Subnet IDs to associate with the network ACL 
        ## INGRESS RULE DECLARATIONS ##
        acl_ingress_rules = { # Mapping of objects for the ingress rules to associate with default network ACL
            ####################################
            ingress_rule_1 = { # Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                    action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                    cidr_block = string # Location from where the traffic is coming from
                    from_port = number # Starting port
                    icmp_code       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                    icmp_type       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                    ipv6_cidr_block = string # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                    protocol = string || -1 # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                    rule_no = number # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                    to_port = number # Ending port
                }
            ####################################
        }
        ## EGRESS RULE DECLARATIONS ##
        acl_egress_rules = { # Mapping of objects for the egress rules to associate with default network ACL
            ####################################
                egress_rule_1 = { # Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                    action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                    cidr_block = string # Location from where the traffic is coming from
                    from_port = number # Starting port
                    icmp_code       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                    icmp_type       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                    ipv6_cidr_block = string # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                    protocol = string || -1 # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                    rule_no = number # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                    to_port = number # Ending port
                }
            ####################################
        }
        ## ACL TAGS ##
        tags = {
            "key" = "value" # Tags to associate with the Network ACL
        }
    }
}
```