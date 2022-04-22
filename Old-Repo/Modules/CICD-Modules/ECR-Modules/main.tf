locals {

  ecr_kms = flatten( [ for ecr, ecr_vals in var.ecr_repositories: 
                        [ for encryption_config, config_vals in ecr_vals.encryption_configuration: config_vals.new_kms_key if config_vals.enabled == true && config_vals.new_kms_key.enabled == true ]
                      ] )

  repo_policy = flatten( [ for ecr, ecr_vals in var.ecr_repositories: {
                          ecr_id = aws_ecr_repository.ecr_repo[ ecr ].id
                          module_key = ecr_vals.repository_policy.module_key
                          ecr_repo_policy_local_path = ecr_vals.repository_policy.ecr_repo_policy_local_path
                        } 
                        if ecr_vals.repository_policy.enabled == true ] )

  lifecycle_policy = flatten( [ for ecr, ecr_vals in var.ecr_repositories: {
                          ecr_id = aws_ecr_repository.ecr_repo[ ecr ].id
                          module_key = ecr_vals.lifecycle_policy.module_key
                          ecr_lifecycle_policy_local_path = ecr_vals.lifecycle_policy.ecr_lifecycle_policy_local_path
                        } 
                        if ecr_vals.lifecycle_policy.enabled == true
  ] )
}

###################################
## ECR Replication Configuration ##
###################################

resource "aws_ecr_replication_configuration" "ecr_replication_config" {
for_each = var.create_replication_configuration == true ? var.replication_configuration : {}

  replication_configuration {
    rule {
      dynamic "destination" {
        for_each = each.value
        content {
          region = destination.value.region
          registry_id = destination.value.registry_id
        }
      }
    }
  }
}

####################
## ECR Repository ##
####################

resource "aws_ecr_repository" "ecr_repo" {
for_each = var.create_ecr_repositories == true ? var.ecr_repositories : {}

  ## ECR Settings ##
  name                 = each.value.ecr_name
  image_tag_mutability = each.value.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }

  ## ECR Encryption ##
  dynamic "encryption_configuration" {
    for_each = each.value.encryption_configuration.value.enabled == true ? each.value.encryption_configuration : {}
    content {
      encryption_type = encryption_configuration.value.encryption_type
      kms_key = encryption_configuration.value.encryption_type == "KMS" ? encryption_configuration.value.new_kms_key.enabled == true ? aws_kms_key.ecr_kms[ encryption_configuration.value.new_kms_key.description ].arn : encryption_configuration.value.kms_key : null
    }
  }

  ## Tags ##
  tags = each.value.ecr_tags
}

## ECR New KMS key ##
resource "aws_kms_key" "ecr_kms" {
for_each = { for o in local.ecr_kms: o.description => o}

  description             = each.value.description
  is_enabled = true
  enable_key_rotation = each.value.enable_key_rotation
  deletion_window_in_days = each.value.deletion_window_in_days
  policy = each.value.policy
  
  tags = each.value.kms_tags
}

###########################
## ECR Repository Policy ##
###########################

resource "aws_ecr_repository_policy" "ecr_repo_policy" {
for_each = { for o in local.repo_policy: o.module_key => o }

  repository = each.value.ecr_id
  policy = file(each.value.ecr_repo_policy_local_path)
}

##########################
## ECR Lifecycle Policy ##
##########################

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
for_each = { for o in local.lifecycle_policy: o.module_key => o }

  repository = each.value.ecr_id
  policy = file(each.value.ecr_lifecycle_policy_local_path)
}



