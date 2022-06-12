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