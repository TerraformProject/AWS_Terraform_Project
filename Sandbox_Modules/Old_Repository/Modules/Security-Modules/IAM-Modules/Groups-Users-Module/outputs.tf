output "this_group_users" {
  description = "List of IAM users in IAM group"
  value       = flatten(aws_iam_group_membership.this.*.users)
}

# output "this_policy_arn" {
#   description = "Assume role policy ARN of IAM group"
#   value       = aws_iam_policy.this_policy.arn
# }

output "group_name" {
  description = "IAM group name"
  value       = aws_iam_group.this.name
}

output "group_arn" {
  description = "IAM group arn"
  value       = aws_iam_group.this.arn
}

output "generated_user_passwords" {
      sensitive = true
      value = {for k, v in aws_iam_user_login_profile.console_users_login_profile: k => v.pgp_key}
    }