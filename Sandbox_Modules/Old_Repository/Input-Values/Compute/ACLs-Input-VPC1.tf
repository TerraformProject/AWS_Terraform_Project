module "ACLS_VPC1" {
source = "../../Modules/Network-Modules/Default-modules/ACL-Modules-Default"

#######################
## VPC1: Default ACl ##
#######################
default_network_acl = {

    Default_Network_ACL = {
        default_network_acl_name = "VPC1_Default_ACL"
        default_network_acl_id = module.VPC_VPC1.vpc.default_network_acl_id
        default_acl_subnet_ids = []

        default_network_acl_ingress = {

            ingress_rule_1 = {
                action = "Deny"
                cidr_block = "0.0.0.0/0"
                from_port = 0
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                protocol = -1
                rule_no = 10
                to_port = 0
                }
            }

        default_network_acl_egress = {

            egress_rule_1 = {
                action = "Deny"
                cidr_block = "0.0.0.0/0"
                from_port = 0
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                protocol = -1
                rule_no = 10
                to_port = 0
                }
            }

        tags = {
            "default_network_acl" = "VPC1_Default_ACL"
        }
    }
    
}


########################
## VPC1: Public NACl ##
########################
public_network_acl = {

    Public_Network_ACL_1 = {
        public_network_acl_name = "VPC1_Public_NACL_1"
        vpc_id = module.VPC_VPC1.vpc.id
        public_acl_subnet_ids = [
            module.VPC_VPC1.public_subnet_1.id,
            module.VPC_VPC1.public_subnet_2.id
        ]

        public_network_acl_ingress = {

            ingress_rule_1 = {
                action = "allow"
                cidr_block = "0.0.0.0/0"
                protocol = -1
                rule_no = 19
                from_port = 0
                to_port = 0
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }

            # ingress_rule_1 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "tcp"
            #     rule_no = 19
            #     from_port = 443
            #     to_port = 443
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }
            

            # ingress_rule_2 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "tcp"
            #     rule_no = 39
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }
            

            # ingress_rule_3 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "udp"
            #     rule_no = 49
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }
            

            # ingress_rule_4 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "tcp"
            #     rule_no = 59
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_5 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "udp"
            #     rule_no = 69
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # # ingress_rule_6 = {
            # #     action = "allow"
            # #     cidr_block = ""
            # #     protocol = "tcp"
            # #     rule_no = 199
            # #     from_port = 22
            # #     to_port = 22
            # #     icmp_code       = null
            # #     icmp_type       = null
            # #     ipv6_cidr_block = null
            # #     }

        }

        public_network_acl_egress = {

            egress_rule_1 = {
                action = "allow"
                cidr_block = "0.0.0.0/0"
                protocol = -1
                rule_no = 19
                from_port = 0
                to_port = 0
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }

            # egress_rule_1 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "tcp"
            #     rule_no = 19
            #     from_port = 443
            #     to_port = 443
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_2 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "tcp"
            #     rule_no = 39
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_3 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "udp"
            #     rule_no = 49
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_4 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "tcp"
            #     rule_no = 59
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_5 = {
            #     action = "allow"
            #     cidr_block = "0.0.0.0/0"
            #     protocol = "udp"
            #     rule_no = 69
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # # egress_rule_6 = {
            # #     action = "allow"
            # #     cidr_block = module.VPC_VPC1.private_subnet_1.cidr_block
            # #     protocol = "tcp"
            # #     rule_no = 298
            # #     from_port = 22
            # #     to_port = 22
            # #     icmp_code       = null
            # #     icmp_type       = null
            # #     ipv6_cidr_block = null
            # #     }

            # # egress_rule_7 = {
            # #     action = "allow"
            # #     cidr_block = module.VPC_VPC1.private_subnet_2.cidr_block
            # #     protocol = "tcp"
            # #     rule_no = 299
            # #     from_port = 22
            # #     to_port = 22
            # #     icmp_code       = null
            # #     icmp_type       = null
            # #     ipv6_cidr_block = null
            # #     }

            # # egress_rule_8 = {
            # #     action = "allow"
            # #     cidr_block = ""
            # #     protocol = "tcp"
            # #     rule_no = 300
            # #     from_port = 22
            # #     to_port = 22
            # #     icmp_code       = null
            # #     icmp_type       = null
            # #     ipv6_cidr_block = null
            # #     }
            # # }
        }

        tags = {
            "public_network_acls" = "VPC1_Public_ACL_1"
        }
    }
}


########################
## VPC1: Private NACl ##
########################
private_network_acl = {

    Private_Network_ACL_1 = {
        private_network_acl_name = "VPC1_Private_NACL_1"
        vpc_id = module.VPC_VPC1.vpc.id
        private_acl_subnet_ids = [
            module.VPC_VPC1.private_subnet_1.id,
            module.VPC_VPC1.private_subnet_2.id
            ]

        private_network_acl_ingress = {

            ingress_rule_1 = {
                action = "allow"
                cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
                protocol = -1
                rule_no = 10
                from_port = 0
                to_port = 0
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }

            ingress_rule_2 = {
                action = "allow"
                cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
                protocol = -1
                rule_no = 11
                from_port = 0
                to_port = 0
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }

            # ingress_rule_1 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "tcp"
            #     rule_no = 10
            #     from_port = 443
            #     to_port = 443
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_2 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "tcp"
            #     rule_no = 11
            #     from_port = 443
            #     to_port = 443
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_3 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "tcp"
            #     rule_no = 30
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_4 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "tcp"
            #     rule_no = 31
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_5 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "udp"
            #     rule_no = 40
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_6 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "udp"
            #     rule_no = 41
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_7 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "tcp"
            #     rule_no = 50
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_8 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "tcp"
            #     rule_no = 51
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_9 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "udp"
            #     rule_no = 60
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_10 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "udp"
            #     rule_no = 61
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_11 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.database_subnet_1.cidr_block
            #     protocol = "tcp"
            #     rule_no = 70
            #     from_port = 3306
            #     to_port = 3306
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_12 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.database_subnet_2.cidr_block
            #     protocol = "tcp"
            #     rule_no = 71
            #     from_port = 3306
            #     to_port = 3306
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # ingress_rule_13 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.database_subnet_3.cidr_block
            #     protocol = "tcp"
            #     rule_no = 72
            #     from_port = 3306
            #     to_port = 3306
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # # ingress_rule_14 = {
            # #     action = "allow"
            # #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            # #     protocol = "tcp"
            # #     rule_no = 299
            # #     from_port = 22
            # #     to_port = 22
            # #     icmp_code       = null
            # #     icmp_type       = null
            # #     ipv6_cidr_block = null
            # #     }

            # # ingress_rule_15 = {
            # #     action = "allow"
            # #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            # #     protocol = "tcp"
            # #     rule_no = 300
            # #     from_port = 22
            # #     to_port = 22
            # #     icmp_code       = null
            # #     icmp_type       = null
            # #     ipv6_cidr_block = null
            # #     }


            }

        private_network_acl_egress = {

            egress_rule_1 = {
                action = "allow"
                cidr_block = "0.0.0.0/0"
                protocol = -1
                rule_no = 10
                from_port = 0
                to_port = 0
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }

            # egress_rule_1 = {
            #     action = "allow"
            #     cidr_block = "192.168.0.0/16"
            #     protocol = "tcp"
            #     rule_no = 10
            #     from_port = 443
            #     to_port = 443
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_2 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "tcp"
            #     rule_no = 30
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_3 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "tcp"
            #     rule_no = 31
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_4 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "udp"
            #     rule_no = 40
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_5 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "udp"
            #     rule_no = 41
            #     from_port = 80
            #     to_port = 80
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_6 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "tcp"
            #     rule_no = 50
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_7 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "tcp"
            #     rule_no = 51
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_7 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "udp"
            #     rule_no = 60
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }
            # egress_rule_8 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "udp"
            #     rule_no = 61
            #     from_port = 1024
            #     to_port = 65535
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }
            
            # egress_rule_8 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.database_subnet_1.cidr_block
            #     protocol = "tcp"
            #     rule_no = 70
            #     from_port = 3306
            #     to_port = 3306
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_9 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.database_subnet_2.cidr_block
            #     protocol = "tcp"
            #     rule_no = 71
            #     from_port = 3306
            #     to_port = 3306
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_10 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.database_subnet_3.cidr_block
            #     protocol = "tcp"
            #     rule_no = 72
            #     from_port = 3306
            #     to_port = 3306
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_11 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_1.cidr_block
            #     protocol = "tcp"
            #     rule_no = 299
            #     from_port = 22
            #     to_port = 22
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }

            # egress_rule_12 = {
            #     action = "allow"
            #     cidr_block = module.VPC_VPC1.public_subnet_2.cidr_block
            #     protocol = "tcp"
            #     rule_no = 300
            #     from_port = 22
            #     to_port = 22
            #     icmp_code       = null
            #     icmp_type       = null
            #     ipv6_cidr_block = null
            #     }


            }

        tags = {
            "private_network_acls" = "VPC1_Private_ACL_1"
        }
    }
}

#########################
## VPC1: Database NACl ##
#########################
database_network_acl = {

    Database_Network_ACL_1 = {
        database_network_acl_name = "VPC1_Database_NACL"
        vpc_id = module.VPC_VPC1.vpc.id
        database_acl_subnet_ids = [
            module.VPC_VPC1.database_subnet_1.id,
            module.VPC_VPC1.database_subnet_2.id,
            module.VPC_VPC1.database_subnet_3.id
            ]

        database_network_acl_ingress = {

            ingress_rule_1 = {
                action = "allow"
                cidr_block = module.VPC_VPC1.private_subnet_1.cidr_block
                protocol = "tcp"
                rule_no = 1
                from_port = 3306
                to_port = 3306
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }
            

            ingress_rule_2 = {
                action = "allow"
                cidr_block = module.VPC_VPC1.private_subnet_2.cidr_block
                protocol = "tcp"
                rule_no = 2
                from_port = 3306
                to_port = 3306
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }
        }

        database_network_acl_egress = {

            egress_rule_1 = {
                action = "allow"
                cidr_block = module.VPC_VPC1.private_subnet_1.cidr_block
                protocol = "tcp"
                rule_no = 1
                from_port = 3306
                to_port = 3306
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }

            egress_rule_2 = {
                action = "allow"
                cidr_block = module.VPC_VPC1.private_subnet_2.cidr_block
                protocol = "tcp"
                rule_no = 2
                from_port = 3306
                to_port = 3306
                icmp_code       = null
                icmp_type       = null
                ipv6_cidr_block = null
                }

            }

            tags = {
                "database_network_acls" = "VPC1_Database_ACL_1"
            }
        }
    }





}



