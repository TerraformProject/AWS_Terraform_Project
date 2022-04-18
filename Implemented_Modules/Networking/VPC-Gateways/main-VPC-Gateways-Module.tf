############################
## VPC Peering Connection ##
############################

resource "aws_vpc_peering_connection" "vpc_peering_connection" {
for_each = var.vpc_peering_connections

peer_owner_id = each.value.peer_owner_id
peer_vpc_id   = each.value.peer_vpc_id
vpc_id        = each.value.vpc_id

accepter {
    allow_remote_vpc_dns_resolution = lookup(each.value.acceptor, "allow_remote_vpc_dns_resolution", null)
    allow_classic_link_to_remote_vpc = lookup(each.value.acceptor, "allow_classic_link_to_remote_vpc", null )
    allow_vpc_to_remote_classic_link = lookup(each.value.acceptor, "allow_vpc_to_remote_classic_link", null )
}

requester {
    allow_remote_vpc_dns_resolution = lookup(each.value.acceptor, "allow_remote_vpc_dns_resolution", null)
    allow_classic_link_to_remote_vpc = lookup(each.value.acceptor, "allow_classic_link_to_remote_vpc", null )
    allow_vpc_to_remote_classic_link = lookup(each.value.acceptor, "allow_vpc_to_remote_classic_link", null )
}
tags = each.value.tags
}

######################
## Internet Gateway ##
######################

resource "aws_internet_gateway" "this" {
for_each = var.internet_gateways

vpc_id = each.value.vpc_id

tags = merge(
    {
    "Name" = each.value.igw_name
    },
    each.value.tags,
    
)
}

##################################
## Egress Only Internet Gateway ##
##################################

resource "aws_egress_only_internet_gateway" "this" {
for_each = var.egress_internet_gateways

vpc_id = each.value.vpc_id

tags = merge(
    {
    "Name" = each.value.egress_igw_name
    },
    each.value.tags,
)
}

##################
## NAT Gateways ##
##################

resource "aws_eip" "nat_gateway_eip" {
count = length( [ for nat_gw, new_eip in var.nat_gateways: new_eip.create_new_eip if new_eip.create_new_eip == true ] )
vpc      = true
}

resource "aws_nat_gateway" "nat_gateway" {
for_each = var.nat_gateways

allocation_id = each.value.create_new_eip == true ? aws_eip.nat_gateway_eip[each.value.new_eip_index].id : each.value.eip_allocation_id
subnet_id     = aws_subnet.subnets[each.value.subnet_id].id

tags = merge( 
{ Name = each.value.nat_gateway_name}, 
each.value.tags,
)

depends_on = [
    aws_eip.nat_gateway_eip
]
}

###########################
## VPC Endpoint Variable ##
###########################

resource "aws_vpc_endpoint" "vpc_endpoints" {
for_each = var.vpc_endpoints

vpc_endpoint_type = each.value.vpc_endpoint_type
service_name = each.value.service_name
vpc_id = each.value.vpc_id
auto_accept = each.value.auto_accept
policy = each.value.policy
private_dns_enabled = each.value.private_dns_enabled
route_table_ids = each.value.route_table_ids
subnet_ids = each.value.subnet_ids
security_group_ids = each.value.security_group_ids
tags = each.value.tags
}

#####################
## Transit Gateway ##
#####################

resource "aws_ec2_transit_gateway" "transit_gateway" {
for_each = var.transit_gateways

description = each.value.description
amazon_side_asn = each.value.amazon_side_asn
auto_accept_shared_attachments = each.value.auto_accept_shared_attachments
default_route_table_association = each.value.default_route_table_association
default_route_table_propagation = each.value.default_route_table_propagation
dns_support = each.value.dns_support
vpn_ecmp_support = each.value.vpn_ecmp_support

tags = each.value.tags
}