#################################
## CodeBuild Project Varaibles ##
#################################

variable "create_codebuild_project" {
    description = "Whether or not to create a CodeBuild Project"
    type = bool
    default = false
}

variable "project_name" {
    description = "Name of the Codebuild Project"
    type = string
    default = ""
}

variable "project_description" {
    description = "Description of the Codebuild Project"
    type = string
    default = ""
}

variable "service_role_arn" {
    description = "Role the CodeBuild Project will assume"
    type = string
    default = ""
}

variable "build_timeout" {
    description = "Timeout for the CodeBuild Project"
    type = string
    default = "60"
}

variable "artifacts" {
    description = "Artifacts for the CodeBuild Project"
    type = object({
        type = string
        name = string
        override_artifacts_name = bool
        namespace_type = string
        artifact_identifier = string
        location = string
        path = string
        packaging = string
        encryption_disabled = bool
    })
    default = null
}

variable "create_secondary_artifacts" {
    description = "Whether or not to create a secondary artifact"
    type = bool
    default = false
}

variable "secondary_artifacts" {
    description = "Values for the secondary artifact"
    type = map(object({
        type = string
        name = string
        override_artifacts_name = bool 
        namespace_type = string
        artifact_identifier = string 
        location = string
        path = string
        packaging = string
        encryption_disabled = bool
    }))
    default = {}
}

variable "create_build_batch_config" {
    description = "Whether or not to create a build batch config for the codeubuild project"
    type = bool
    default = false
}

variable "build_batch_config" {
    description = "build batch configurations for the codebuild project"
    type = map(object({
        combine_artifacts = bool
        restrictions = object({
            compute_types_allowed = list(string)
            maximum_builds_allowed = number
        })
        service_role = string
        timeout_in_mins = number
    }))
    default = null
}

variable "create_cache" {
    description = "Whether to create cache for the CodeBuild Project or not"
    type = bool
    default = false
}

variable "cache" {
    description = "Cache for the CodeBuild Project"
    type = map(object({
        type = string
        location = string
        modes = list(string)
    }))
    default = {}
}

variable "environment" {
    description = "Environment for the CodeBuild Project"
    type = object({
        compute_type = string
        image = string
        privileged_mode = bool
        type = string
        image_pull_credentials_type = string
        certificate = string
        create_registry_credential = bool
        registry_credential = map(string)
        create_environment_variables = bool
        environment_variable = map(object({
            name = string
            value = string
            type = string
        }))
    })
    default = null
}

variable "concurrent_build_limit" {
    description = "Limit to number of concurrent build limits"
    type = number
    default = null
}

variable "create_logs_config" {
    description = "Whether to create configuration for logs in CodeBuild Project"
    type = bool 
    default = false
}

variable "logs_config" {
    description = "Configuration for logs in CodeBuild Project"
    type = map(object({
        create_cloudwatch_logs = bool
        cloudwatch_logs = map(map(string))
        create_s3_logs = bool
        s3_logs = map(object({
            encryption_disabled = bool
            status = string
            location = string
        }))
    }))
}

variable "source_version" {
    description = "The source version of the COdeBuild Project"
    type = string
    default = ""
}

variable "create_vpc_config" {
    description = "Whether or not create a VPC configuration for the Codebuild Project"
    type = bool
    default = false
}

variable "vpc_config" {
    description = "VPC configuration for the Codebuild project"
    type = map(object({
        vpc_id = string
        subnets = list(string)
        security_group_ids = list(string)
    }))
    default = null
}

variable "codebuild_project_tags" {
    description = "Tags for the CodeBuild Project"
    type = map(string)
    default = {}
}

variable "primary_source" {
    description = "Source for the CodeBuild Project"
    type = object({
        type = string
        buildspec = string
        location = string
        git_clone_depth = number
        insecure_ssl = bool
        git_submodules_config = map(bool)
        report_build_status = bool
        build_status_config = map(string)
    }) 
    default = null
}

variable "create_secondary_sources" {
    description = "Whether or not to create a secondary source for the CodeBuild Project"
    type = bool
    default = false
}

variable "secondary_sources" {
    description = "Source for the CodeBuild Project"
    type = map(object({
        type = string
        buildspec = string
        source_identifier = string
        location = string
        git_clone_depth = number
        insecure_ssl = bool
        git_submodules_config = map(bool)
        report_build_status = bool
        build_status_config = map(string)
    })) 
    default = null
}

#####################################
## Codebuild Report Group Variable ##
#####################################

variable "create_report_group" {
    description = "Whether or not to create a report group for the Codebuild Project"
    type = bool
    default = false
}

variable "report_group" {
    description = "Report group settings for the codebuild project"
    type = map(object({
        name = string
        type = string
        delete_reports = bool
        export_config = object({
            type = string
            s3_destination = object({
                bucket = string
                encryption_key = string
                encryption_disabled = bool
                packaging = string
                path = string
            })
        })
        tags = map(string)
    }))
}

#########################################
## Codebuild Project Webhook Variables ##
#########################################

variable "create_github_webhook" {
    description = "Whether or not to create a github webhook"
    type = bool 
    default = false
}

variable "github_webhook" {
    description = "Webhook to be specified from github to trigger a build"
    type = map(object({
        active = bool
        events = list(string)
        name = string
        repository = string
        configuration = object({
            url = string
            secret = string
            content_type = string
            insecure_ssl = bool
        })
    }))
    sensitive = true
    default = null
}

variable "create_bitbucket_webhook" {
    description = "Whether to create a bitbucket webhook or not"
    type = bool 
    default = false
}

variable "bitbucket_webhook" {
    description = "Webhook to be specified from bitbucket to trigger a build"
    type = map(object({
        owner = string
        repository = string
        url = string
        description = string
        events = list(string)
    }))
    sensitive = true
    default = null
}