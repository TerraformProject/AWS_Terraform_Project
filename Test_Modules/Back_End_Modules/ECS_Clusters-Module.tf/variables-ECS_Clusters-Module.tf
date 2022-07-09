###########################
## ECS Cluster Variables ##
###########################

variable "ecs_clusters" {
    description = "Variable to create ECS Clusters"
    type = map(object({
        #- ECS CLuster -#
        name = string
        #- Host-Container Encryption -#
        kms_key_id = string
        new_kms_key = object({
            key_name = string
            description = string
            is_enabled = bool
            key_usage = string
            customer_master_key_spec = string
            enable_key_rotation = bool
            multi_region = bool
            policy_file = string
            bypass_policy_lockout_safety_check = bool
            deletion_window_in_days = number
            kms_tags = map(string)
        })
        #- Metric Log Configuration -#
        enable_container_insights = bool
        logging = string
        log_exports = object({
            cloudwatch = object({
                enabled = bool
                log_group_name = string
                encryption_enabled = bool
            })
            s3_bucket = object({
                enabled = bool
                bucket_name = string
                bucket_folder = string
                encryption_enabled = bool
            })
        })
    }))
  
}