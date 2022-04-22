#########################################
## Replication Configuration Variables ##
#########################################

variable "create_replication_configuration" {
    description = "Whether to create a replication configuration"
    type = bool 
    default = false
}

variable "replication_configuration" {
    description = "Setting for replication configuration"
    type = map(map(map(string)))
}

#############################
## ECR Repository Variable ##
#############################

variable "create_ecr_repositories" {
    description = "Whether to create ECR repositories"
    type = bool
    default = false
}

variable "ecr_repositories" {
    description = "Settings for creating ECR repositoires"
    type = map(object({
        ecr_name = string
        image_tag_mutability = string
        scan_on_push = bool
        encryption_configuration = map(object({
            enabled = bool
            encryption_type = string
            kms_key = string
            new_kms_key = object({
                enabled = bool
                description = string
                enable_key_rotation = bool
                deletion_window_in_days = number
                policy = string
                kms_tags = map(string)
            })
        }))
        repository_policy = object({
            enabled = bool
            module_key = string
            ecr_repo_policy_local_path = string
        })
        lifecycle_policy = object({
            enabled = bool
            module_key = string
            ecr_lifecycle_policy_local_path = string
        })
        ecr_tags = map(string)
    }))
    default = null
}

