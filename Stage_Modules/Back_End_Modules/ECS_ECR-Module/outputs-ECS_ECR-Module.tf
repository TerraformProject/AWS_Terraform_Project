##########################################
## Elastic Container Repository Outputs ##
##########################################
#- Sample -----------------------------#
# output "ecr_repository_index_key_export_attribute" {
#   value = aws_ecr_repository.ecr_repo["ecr_repository_index_key"].export_attribute
# }
#--------------------------------------#

output "ecr_repo_005_arn" {
  value = aws_ecr_repository.ecr_repo["ecr_repo_005"].arn
}

output "ecr_repo_005_registry_id" {
  value = aws_ecr_repository.ecr_repo["ecr_repo_005"].registry_id
}

output "ecr_repo_005_repository_url" {
  value = aws_ecr_repository.ecr_repo["ecr_repo_005"].repository_url
}

