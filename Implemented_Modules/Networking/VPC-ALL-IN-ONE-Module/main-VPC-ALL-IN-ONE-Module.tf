#########
## VPC ##
#########

resource "aws_vpc" "vpc" {
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
  count = var.associate_cidr_blocks == true ? length(var.cidr_blocks_associated) : 0

  vpc_id = aws_vpc.vpc[0].id
  cidr_block = var.cidr_blocks_associated[count.index]
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

  vpc_id          = aws_vpc.vpc[0].id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}

#########################
## Default route table ##
#########################

resource "aws_default_route_table" "default" {
  count = var.manage_default_route_table ? 1 : 0

  default_route_table_id = var.default_route_table_id
  propagating_vgws       = var.default_route_table_propagating_vgws == [] ? null : var.default_route_table_propagating_vgws 

  dynamic "route" {
    for_each = var.default_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = lookup(route.value, "cidr_block", null)
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null )
      destination_prefix_list_id = lookup(route.value, "destination_prefix_list_id", null )

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null) != null ? aws_egress_only_internet_gateway.this[lookup(route.value, "egress_only_gateway_id", null)].id : null
      gateway_id             = lookup(route.value, "gateway_id", null ) != null ? aws_internet_gateway.this[lookup(route.value, "gateway_id", null )].id : null
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null ) != null ? aws_nat_gateway.nat_gateway[lookup(route.value, "nat_gateway_id", null )].id : null
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null) != null ? aws_ec2_transit_gateway.transit_gateway[lookup(route.value, "transit_gateway_id", null)].id : null
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null) != null ? aws_ec2_transit_gateway.transit_gateway[lookup(route.value, "vpc_endpoint_id", null)].vpc_endpoint_type : null
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null) != null ? aws_vpc_peering_connection.vpc_peering_connection[lookup(route.value, "vpc_peering_connection_id", null)].id : null
    }
  }

  tags = merge(
    { "Name" = var.default_route_table_name },
    var.default_route_table_tags,
  )
}

##################
## Route Tables ##
##################
resource "aws_route_table" "route_tables" {
  for_each = var.route_tables

  vpc_id = each.value.vpc_id
  propagating_vgws = each.value.propagating_vgws

  dynamic "route" {
    for_each = each.value.associated_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = lookup(route.value, "cidr_block", null)
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
      destination_prefix_list_id = lookup(route.value, "destination_prefix_list_id", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null) != null ? aws_egress_only_internet_gateway.this[lookup(route.value, "egress_only_gateway_id", null)].id : null
      gateway_id             = lookup(route.value, "gateway_id", null ) != null ? aws_internet_gateway.this[lookup(route.value, "gateway_id", null )].id : null
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null ) != null ? aws_nat_gateway.nat_gateway[lookup(route.value, "nat_gateway_id", null )].id : null
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null) != null ? aws_ec2_transit_gateway.transit_gateway[lookup(route.value, "transit_gateway_id", null)].id : null
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null) != null ? aws_ec2_transit_gateway.transit_gateway[lookup(route.value, "vpc_endpoint_id", null)].vpc_endpoint_type : null
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null) != null ? aws_vpc_peering_connection.vpc_peering_connection[lookup(route.value, "vpc_peering_connection_id", null)].id : null
    }
  }

  tags = merge(
    {
      "Name" = each.value.route_table_name
    },
    each.value.tags
  )
}

############
## Subnet ##
############

resource "aws_subnet" "subnets" {
  for_each = var.subnets 

  vpc_id = each.value.vpc_id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  customer_owned_ipv4_pool = each.value.customer_owned_ipv4_pool
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  ipv6_cidr_block = each.value.ipv6_cidr_block == "" ? null : each.value.ipv6_cidr_block
  map_customer_owned_ip_on_launch = each.value.map_customer_owned_ip_on_launch
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  outpost_arn = each.value.outpost_arn
  tags = merge(
    {
      "Name" = each.value.subnet_name
    },
    each.value.tags,
  )
}

#####################################
## Subnet Route Table Associations ##
#####################################

resource "aws_route_table_association" "route_table_associations" {
for_each = var.subnets

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.route_tables[each.value.route_table_association].id
}

########################
## Destination Routes ##
########################

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

###########################
## Route53: Hosted Zones ##
###########################

resource "aws_route53_zone" "this" {
  for_each = var.hosted_zones

  name          = each.value.name
  comment       = each.value.comment
  force_destroy = each.value.force_destroy
  delegation_set_id = each.value.private_zone == true ? null : each.value.delegation_set_id

  dynamic "vpc" {
    for_each = each.value.private_zone == true ? each.value.private_zone_settings : {}
    content {
      vpc_id     = lookup(each.value.private_zone_settings, "vpc_id", null)
      vpc_region = lookup(each.value.private_zone_settings, "region", null)
    }
  }

  tags = each.value.tags
}

###########################
## Route53: Zone Records ##
###########################

resource "aws_route53_record" "this" {
  for_each = var.route53_records

  zone_id = aws_route53_zone.this[each.value.zone_key].zone_id

  name            = each.value.name != "" ? "${each.value.name}.${aws_route53_zone.this[each.value.zone_key].name}" : aws_route53_zone.this[each.value.zone_key].name
  type            = each.value.type
  ttl             = each.value.create_alias == true ? null : each.value.ttl  
  multivalue_answer_routing_policy = each.value.set_identifier != "failover" && each.value.set_identifier != "latency" && each.value.set_identifier != "geolocation" && each.value.set_identifier != "weighted" ? each.value.multivalue_answer_routing_policy : null
  records         = each.value.create_alias == true ? null : each.value.records
  set_identifier  = each.value.set_identifier == "" ? null : each.value.set_identifier
  health_check_id = each.value.health_check_id == "" ? null : each.value.health_check_id

  dynamic "alias" {
    for_each = each.value.create_alias == true ? each.value.alias : {}

    content {
      name                   = alias.value.name
      zone_id                = aws_route53_zone.this[alias.value.zone_key].zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }

  dynamic "failover_routing_policy" {
    for_each = each.value.set_identifier == "failover" && each.value.multivalue_answer_routing_policy != true ? each.value.policy : {}

    content {
      type = lookup(each.value.policy, "type", null)
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = each.value.set_identifier == "weighted" && each.value.multivalue_answer_routing_policy != true  ? each.value.policy : {}

    content {
      weight = lookup(each.value.policy, "weight", null)
    }
  }

   dynamic "latency_routing_policy" {
    for_each = each.value.set_identifier == "latency" && each.value.multivalue_answer_routing_policy != true  ? each.value.policy : {} 

    content {
      region = lookup(each.value.policy, "region", null)
    }
   }

   dynamic "geolocation_routing_policy" {
     for_each = each.value.set_identifier == "geolocation" && each.value.multivalue_answer_routing_policy != true  ? each.value.policy : {}
     content {
       continent = lookup(each.value.policy, "continent", null)
       country = lookup(each.value.policy, "country", null)
       subdivision = lookup(each.value.policy, "subdivision", null)
     }
   }

  allow_overwrite = each.value.allow_overwrite
}

