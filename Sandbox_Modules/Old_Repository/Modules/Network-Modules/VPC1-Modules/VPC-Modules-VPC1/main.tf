#########
## VPC ##
#########

resource "aws_vpc" "vpc1" {
  count = var.create_vpc ? 1 : 0

  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.vpc_tags,
  )
}

###############################
## VPC: Secondary CIDR Block ##
###############################

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = var.create_vpc && length(var.sub_cidr_blocks) > 0 ? length(var.sub_cidr_blocks) : 0

  vpc_id = var.vpc_id_sub_cidr

  cidr_block = element(var.sub_cidr_blocks, count.index)
}

######################
## DHCP Options Set ##
######################

resource "aws_vpc_dhcp_options" "this" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  domain_name          = var.dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = merge(
    {
      "Name" = format("%s", var.dhcp_options_set_name)
    },
    var.dhcp_options_tags,
  )
}

###################################
## DHCP Options Set Assocoiation ##
###################################

resource "aws_vpc_dhcp_options_association" "this" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  vpc_id          = var.vpc_id_dhcp_options
  dhcp_options_id = var.dhcp_options_id
}

