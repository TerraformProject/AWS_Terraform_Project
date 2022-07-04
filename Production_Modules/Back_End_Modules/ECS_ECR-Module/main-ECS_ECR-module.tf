locals {

  replication_config = flatten([ for rule, rule_values in var.replication_config_rules: {
                                  index_key = rule
                                  ecr_repo_name = rule_values.ecr_repo_name
                                  region = rule_values.destination.region
                                  registry_id = rule_values.destination.registry_id
                              } if rule_values.enabled == true
   ])

  registry_scanning = flatten([ for rule, rule_values in var.scan_rules: {
                                  rule_index_key = rule
                                  enabled = rule_values.enabled
                                  filter = rule_values.filter
                                  scan_frequency = rule_values.scan_frequency
                                } if rule_values.enabled == true
                              ] )

  repo_lifecycle_hook = flatten([ for repo, repo_values in var.ecr_repositories: {
                                    repo_index_key = repo
                                    lifecycle_hook_policy_file = repo_values.lifecycle_hook_policy_file
                                } if repo_values.enable_lifecycle_hook_policy == true
                              ] )

  ecr_pull_through_cache = flatten([ for repo, repo_values in var.ecr_repositories: {
                                      repo_index_key = repo
                                      upstream_registry_url = repo_values.upstream_registry_url
                                    } if repo_values.enable_pull_through_cache == true
  ] )

  repo_kms_key = flatten([ for repo, repo_values in var.ecr_repositories: {
                          key_name = repo_values.new_kms_key.key_name
                          description = repo_values.new_kms_key.description
                          is_enabled = repo_values.new_kms_key.is_enabled
                          key_usage = repo_values.new_kms_key.key_usage
                          cstmr_mstr_key_spec = repo_values.new_kms_key.cstmr_mstr_key_spec
                          enable_key_rotation = repo_values.new_kms_key.enable_key_rotation
                          multi_region = repo_values.new_kms_key.multi_region
                          policy_file = repo_values.new_kms_key.policy_file
                          bypass_policy_lockout_safety_check = repo_values.new_kms_key.bypass_policy_lockout_safety_check
                          deletion_window_in_days = repo_values.new_kms_key.deletion_window_in_days
                          kms_tags = repo_values.new_kms_key.kms_tags
                          } if repo_values.encryption_type == "KMS" && repo_values.new_kms_key.key_name != ""
                        ] )

  repo_access_policy = flatten( [ for repo, repo_values in var.ecr_repositories: {
                                    repo_index_key = repo
                                    repo_access_policy_file = repo_values.repo_access_policy_file
                                } if repo_values.repo_access_policy_file != ""
                              ] )

  
}

#################################
## ECR Private Registry Policy ##
#################################
resource "aws_ecr_registry_policy" "private_registry_policy" {
count = var.registry_access_policy_file != "" ? 1 : 0

  policy = file(var.registry_access_policy_file)
}

################################
## ECR Scanning Configuration ##
################################
resource "aws_ecr_registry_scanning_configuration" "configuration" {
count = length( flatten( [ for rule, rule_values in var.scan_rules: rule if rule_values.enabled == true ] ) ) >= 1 ? 1 : 0

  scan_type = var.scan_type 

  dynamic "rule" {
  for_each = { for o in local.registry_scanning: o.rule_index_key => o }
  content {
      scan_frequency = rule.value.scan_frequency
      repository_filter {
        filter      = rule.value.filter
        filter_type = "WILDCARD"
      }
    }
  }
}

###################################
## ECR Replication Configuration ##
###################################
resource "aws_ecr_replication_configuration" "ecr_rep_config" {
 count = length( flatten([ for rule, rule_enabled in var.replication_config_rules: rule if rule_enabled.enabled == true ])) >= 1 ? 1 : 0
  replication_configuration {
    dynamic "rule" {
      for_each = { for o in local.replication_config: o.index_key => o }
      content {
      destination {
        region      = rule.value.region
        registry_id = rule.value.registry_id == "self" ? data.aws_caller_identity.current.account_id : rule.value.registry_id
      }

      repository_filter {
        filter      = rule.value.ecr_repo_name
        filter_type = "PREFIX_MATCH"
      }
      }
    }
  }
}

# Used if registry id == "self" # Useful for replication config is in same AWS account
# but different region
data "aws_caller_identity" "current" {}

############################
## ECR Pull through Cache ##
############################
resource "aws_ecr_pull_through_cache_rule" "ecr_pull_cache" {
for_each = { for o in local.ecr_pull_through_cache: o.repo_index_key => o }

  ecr_repository_prefix = aws_ecr_repository.ecr_repo[each.value.repo_index_key].name
  upstream_registry_url = each.value.upstream_registry_url

  depends_on = [
    aws_ecr_repository.ecr_repo
  ]
}

####################
## ECR Repository ##
####################

resource "aws_ecr_repository" "ecr_repo" {
for_each = var.ecr_repositories

  name                 = each.value.name
  image_tag_mutability = each.value.image_tag_mutability

  encryption_configuration {
    encryption_type = each.value.encryption_type
    kms_key = each.value.encryption_type == "KMS" ? each.value.new_kms_key.key_name != "" ? aws_kms_key.ecr_kms[each.value.new_kms_key.key_name].arn : each.value.existing_kms_key_arn : null
  }

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }

  tags = each.value.repo_tags
}

## ECR New KMS key ##
resource "aws_kms_key" "ecr_kms" {
for_each = { for o in local.repo_kms_key: o.key_name => o}

      description = each.value.description
      is_enabled = each.value.is_enabled
      key_usage = each.value.key_usage
      customer_master_key_spec = each.value.cstmr_mstr_key_spec == "" ? null : each.value.cstmr_mstr_key_spec
      enable_key_rotation = each.value.enable_key_rotation
      multi_region = each.value.multi_region
      policy = each.value.policy_file != "" ? file(each.value.policy_file) : null
      bypass_policy_lockout_safety_check = each.value.bypass_policy_lockout_safety_check
      deletion_window_in_days = each.value.deletion_window_in_days

      tags = merge(
        {Name = each.value.key_name },
        each.value.kms_tags
        )
}

##########################
## ECR Lifecycle Policy ##
##########################

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
for_each = { for o in local.repo_lifecycle_hook: o.repo_index_key => o }

  repository = aws_ecr_repository.ecr_repo[each.value.repo_index_key].name

  policy = file(each.value.lifecycle_hook_policy_file)
}

############################
## ECR REPO ACCESS POLICY ##
############################
resource "aws_ecr_repository_policy" "access_policy" {
for_each = { for o in local.repo_access_policy: o.repo_index_key => o }

  repository = aws_ecr_repository.ecr_repo[each.value.repo_index_key].name
  policy = file(each.value.repo_access_policy_file)
}



