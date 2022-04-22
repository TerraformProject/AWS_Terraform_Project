########################################
## Elastic Container Registry Outputs ##
########################################

output "ecr_1" {
    value = aws_ecr_repository.ecr_repo["ecr_1"]
}