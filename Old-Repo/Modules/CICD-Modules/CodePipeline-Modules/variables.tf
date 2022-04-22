############################
## Codepipeline Variables ##
############################

variable "create_codepipeline" {
    description = "Whether to create a codepipeline or not"
    type = bool
    default = false
}

variable "codepipeline_name" {
    description = "Name of the codepipeline"
    type = string
    default = null
}

variable "codepipeline_role_arn" {
    description = "role arn for the codepipeline"
    type = string
    default = null
}

variable "artifact_store_location" {
    description = "location for codepipeline artifact storage"
    type = string
    default = null
}

variable "artifact_store_type" {
    description = "Type 0f artifact storage"
    type = string
    default = null
}

variable "enable_cross_region_artifact_storage" {
    description = "Whether or not to a put codepipeline artifacts in seperate regions."
    type = bool
    default = false
}

variable "region" {
    description = "The region to use to put codepipeline artifacts"
    type = string
    default = null
}

variable "encryption_key_id" {
    description = "ID of the encryption key"
    type = string
    default = null
}

variable "encryption_key_type" {
    description = "Type of the encryption key"
    type = string
    default = null
}

variable "codepipeline_stages" {
    description = "Stages to be specified for the pipeline"
    type = map(object({
        name = string
        action = map(object({
        run_order = number
        category = string
        owner = string
        provider = string
        version = string
        input_artifacts = list(string)
        output_artifacts = list(string)
        namespace = string
        configuration = map(any)
        }))
    }))
    default = null
}

