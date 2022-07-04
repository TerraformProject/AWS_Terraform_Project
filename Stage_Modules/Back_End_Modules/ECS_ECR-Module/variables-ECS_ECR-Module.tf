####################################
#- Registry Policy ----------------#
####################################

variable "registry_access_policy_file" {
  description = "Local path to policy file with valid JSON syntax"
  type = string
  default = ""
}

####################################
#- Registry Scanning Config -------#
####################################

variable "scan_type" {
    description = "What type of scanning ECR will perform for images"
    type = string
    default = "BASIC"
}

variable "scan_rules" {
  description = "Rules to specify how repositories wil be scanned"
  type = map(object({
    enabled = bool
    filter = string
    scan_frequency = string
  }))
  default = {}
}

####################################
#- Replication Config -------------#
####################################
variable "replication_config_rules" {
  description = "Rules for how replication of respositries will take place"
  type = map(object({
    enabled = bool
    ecr_repo_name = string
    destination = map(string)
  }))
  default = {}
}

##############################
## ECR Private Repositories ##
##############################

variable "ecr_repositories" {
  description = "The repositories that will be created within the private registry"
  type = map(object({
        name = string
        image_tag_mutability = string
        enable_pull_through_cache = bool
        upstream_registry_url = string
        enable_lifecycle_hook_policy = bool
        lifecycle_hook_policy_file = string
        scan_on_push = bool
        encryption_type = string
        existing_kms_key_arn = string
        new_kms_key = object({
            key_name = string
            description = string
            is_enabled = bool
            key_usage = string
            cstmr_mstr_key_spec = string
            enable_key_rotation = bool
            multi_region = bool
            policy_file = string
            bypass_policy_lockout_safety_check = bool
            deletion_window_in_days = number
            kms_tags = map(string)
        })
        repo_access_policy_file = string
        repo_tags = map(string)
  }))
}


















