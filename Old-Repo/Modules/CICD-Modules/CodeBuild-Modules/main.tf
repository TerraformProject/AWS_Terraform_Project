#######################
## CodeBuild Project ##
#######################

resource "aws_codebuild_project" "example" {
count = var.create_codebuild_project == true ? 1 : 0

  name          = var.project_name
  description   = var.project_description
  build_timeout = var.build_timeout
  service_role  = var.service_role_arn

  artifacts {
    type = var.artifacts["type"]
    name = var.artifacts["name"] == "" ? null : var.artifacts["name"]
    override_artifact_name = var.artifacts["override_artifacts_name"] 
    namespace_type = var.artifacts["namespace_type"] == "" ? null : var.artifacts["namespace_type"]
    artifact_identifier = var.artifacts["artifact_identifier"] == "" ? null : var.artifacts["artifact_identifier"]
    location = var.artifacts["location"] == "" ? null : var.artifacts["location"]
    path = var.artifacts["path"] == "" ? null : var.artifacts["path"]
    packaging = var.artifacts["packaging"] == "" ? null : var.artifacts["packaging"] 
    encryption_disabled = var.artifacts["encryption_disabled"]
  }

  dynamic "secondary_artifacts" {
    for_each = var.create_secondary_artifacts == true ? var.secondary_artifacts : {}
    content {
      type = secondary_artifacts.value.type
      name = secondary_artifacts.value.name == "" ? null : secondary_artifacts.value.name
      override_artifact_name = secondary_artifacts.value.override_artifacts_name 
      namespace_type = secondary_artifacts.value.namespace_type == "" ? null : secondary_artifacts.value.namespace_type
      artifact_identifier = secondary_artifacts.value.artifact_identifier == "" ? null : secondary_artifacts.value.artifact_identifier
      location = secondary_artifacts.value.location == "" ? null : secondary_artifacts.value.location
      path = secondary_artifacts.value.path == "" ? null : secondary_artifacts.value.path
      packaging = secondary_artifacts.value.packaging == "" ? null : secondary_artifacts.value.packaging
      encryption_disabled = secondary_artifacts.value.encryption_disabled
    }
  }

  dynamic "build_batch_config" {
      for_each = var.create_build_batch_config == true ? var.build_batch_config : {}
      content {
          combine_artifacts = build_batch_config.value.combine_artifacts
          restrictions {
              compute_types_allowed = build_batch_config.value.restrictions.compute_types_allowed
              maximum_builds_allowed = build_batch_config.value.restrictions.maximum_builds_allowed
          }
          service_role = build_batch_config.value.service_role
          timeout_in_mins = build_batch_config.value.timeout_in_mins
      }
  }

  dynamic "cache" {
    for_each = var.create_cache == true ? var.cache : {}
    content {
    type     = cache.value.type
    location = cache.value.location
    modes = cache.value.modes
    }
  }

  environment {
    compute_type                = var.environment["compute_type"]
    image                       = var.environment["image"]
    type                        = var.environment["type"]
    image_pull_credentials_type = var.environment["image_pull_credentials_type"] == "" ? null : var.environment["image_pull_credentials_type"]
    certificate = var.environment["certificate"] == "" ? null : var.environment["certificate"]

    dynamic "registry_credential" {
    for_each = var.environment["create_registry_credential"] == true && var.environment["image_pull_credentials_type"] == "" ? var.environment["registry_credential"] : {}
    content {
        credential = var.environment["registry_credential"].credential
        credential_provider = var.environment["registry_credential"].credential_provider
    }
    }

    dynamic "environment_variable" {
    for_each = var.environment["create_environment_variables"] == true ? var.environment["environment_variable"] : {}
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type = environment_variable.value.type
        }
      }
}

concurrent_build_limit = var.concurrent_build_limit

  dynamic "logs_config" {
    for_each = var.create_logs_config == true ? var.logs_config : {}
    content {
    dynamic "cloudwatch_logs" {
    for_each = logs_config.value.create_cloudwatch_logs == true ? logs_config.value.cloudwatch_logs : {}
    content {
      group_name  = cloudwatch_logs.value.group_name
      stream_name = cloudwatch_logs.value.stream_name
      status = cloudwatch_logs.value.status
      }
    }
    dynamic "s3_logs" {
    for_each = logs_config.value.create_s3_logs == true ? logs_config.value.s3_logs : {}
    content {
      encryption_disabled = s3_logs.value.encryption_disabled
      status   = s3_logs.value.status
      location = s3_logs.value.location
      }
    }
  }
}

  source_version = var.source_version

  source {
    type            = var.primary_source["type"]
    buildspec = var.primary_source["buildspec"]
    location        = var.primary_source["location"]
    git_clone_depth = var.primary_source["git_clone_depth"]
    insecure_ssl = var.primary_source["insecure_ssl"]

    dynamic "git_submodules_config" {
      for_each = var.primary_source["type"] == "CODECOMMIT" || var.primary_source["type"] == "GITHUB" || var.primary_source["type"] == "GITHUB_ENTERPRISE" ? var.primary_source["git_submodules_config"] : {}
      content {
        fetch_submodules = var.primary_source["git_submodules_config"].fetch_submodules
      }
    }

    report_build_status = var.primary_source["type"] == "GITHUB" || var.primary_source["type"] == "GIT_ENTERPRISE" || var.primary_source["type"] == "BITBUCK" ? var.primary_source["report_build_status"] : null
    dynamic "build_status_config" {
      for_each = var.primary_source["report_build_status"] == true ? var.primary_source["build_status_config"] : {} 
      content {
        context = var.primary_source["build_status_config"].context
        target_url = var.primary_source["build_status_config"].target_url
      }
    }

}

  dynamic "secondary_sources" {
    for_each = var.create_secondary_sources == true ? var.secondary_sources : {}
    content {
      type            = secondary_sources.value.type
      buildspec = secondary_sources.value.buildspec
      source_identifier = secondary_sources.value.source_identifier
      location        = secondary_sources.value.location
      git_clone_depth = secondary_sources.value.git_clone_depth
      insecure_ssl = secondary_sources.value.insecure_ssl

      dynamic "git_submodules_config" {
        for_each = secondary_sources.value.type == "CODECOMMIT" || secondary_sources.value.type == "GITHUB" || secondary_sources.value.type == "GITHUB_ENTERPRISE" ? secondary_sources.value.git_submodules_config : {}
        content {
          fetch_submodules = secondary_sources.value.git_submodules_config.fetch_submodules
        }
      }

      report_build_status = secondary_sources.value.type == "GITHUB" || secondary_sources.value.type == "GIT_ENTERPRISE" || secondary_sources.value.type == "BITBUCK" ? secondary_sources.value.report_build_status : null
      dynamic "build_status_config" {
        for_each = secondary_sources.value.report_build_status == true ? secondary_sources.value.build_status_config : {} 
        content {
          context = secondary_sources.value.build_status_config.context
          target_url = secondary_sources.value.build_status_config.target_url
        }
      }
    }
  }

  dynamic "vpc_config" {
    for_each = var.create_vpc_config == true ? var.vpc_config : {}
    content {
    vpc_id = vpc_config.value.vpc_id
    subnets = vpc_config.value.subnets
    security_group_ids = vpc_config.value.security_group_ids
  }
}

  tags = var.codebuild_project_tags
}

############################
## Codebuild Report Group ##
############################

resource "aws_codebuild_report_group" "example" {
for_each = var.create_report_group == true ? var.report_group : {} 
  name = each.value.name
  type = each.value.type

  export_config {
    type = each.value.export_config.type
    s3_destination {
      bucket              = each.value.export_config.s3_destination.bucket
      encryption_disabled = each.value.export_config.s3_destination.encryption_disabled
      encryption_key      = each.value.export_config.s3_destination.encryption_key
      packaging           = each.value.export_config.s3_destination.packaging
      path                = each.value.export_config.s3_destination.path
    }
  }

  tags = each.value.tags
}

#########################
## Codebuild Web Hooks ##
#########################

# resource "aws_codebuild_webhook" "example" {
# count = var.create_github_webhook == true ? 1 : 0 
#   project_name = aws_codebuild_project.example[0].name
# }

# resource "github_repository_webhook" "example" {
# for_each = var.create_github_webhook == true ? var.github_webhook : {} 
#   active     = each.value.active
#   events     = each.value.push
#   name       = each.value.name
#   repository = each.value.repository

#   configuration {
#     url          = aws_codebuild_webhook.example[0].payload_url
#     secret       = aws_codebuild_webhook.example[0].secret
#     content_type = each.value.configuration.content_type
#     insecure_ssl = each.value.configuration.insecure_ssl
#   }

#   depends_on = [
#     aws_codebuild_webhook.example
#   ]
# }

# resource "bitbucket_hook" "deploy_on_push" {
# for_each = var.create_bitbucket_webhook == true ? var.bitbucket_webhook : {} 
#   owner       = each.value.owner
#   repository  = each.value.repository
#   url         = aws_codebuild_webhook.example[0].payload_url 
#   description = each.value.description

#   events = each.value.events
# }