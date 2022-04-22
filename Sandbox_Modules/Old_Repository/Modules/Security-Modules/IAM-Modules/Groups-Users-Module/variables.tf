variable "name_group" {
  description = "Name of IAM Group & IAM Group Policy"
  type        = list(string)
  default = []
}

variable "path_group" {
  description = "Path to put group policy in the AWS console"
  type        = list(string)
  default = []
}

variable "group_memebers" {
  description = "Group members to add to the newly created group"
  type        = list(string)
  default = []
}

variable "membership_name" {
  description = "Name of mebership when users are added to the group"
  type        = list(string)
  default = []
}

variable "group_policy_name" {
  description = "Name of IAM Group Policy"
  type        = list(string)
  default = []
}

variable "put_path_aws_group_policy" {
  description = "Path to put IAM group policy on AWS console"
  type        = list(string)
  default = []
}

variable "group_policy_local_path" {
  description = "Local path of json policy to use for IAM group policy"
  type        = list(string)
  default = null
}

variable "add_existing_console_users" {
  description = "Current users on the AWS console to add to the group"
  type        = list(string)
  default = []
}

variable "users_with_console_access" {
  description = "If the password should be reset when the new user logs in to their account"
  type        = list(string)
  default = []
}

variable "password_reset_required" {
  description = "If users should be required to reset their password"
  type        = list(string)
  default = []
}

variable "put_path_console_users" {
  description = "Path on AWS console where users will be located"
  type        = list(string)
  default = []
}

variable "create_access_keys" {
  description = "Users who will be given access keys"
  type        = map(string)
  default = {}
  sensitive = true
}

variable "force_destroy" {
  description = "Should all access keys, even ones not managed by terraform, be destroyed upon deletion of user"
  type        = list(string)
  default = []
}