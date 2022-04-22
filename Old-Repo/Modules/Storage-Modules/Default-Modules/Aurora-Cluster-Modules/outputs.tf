###############################
## Aurora Serverless Outputs ##
###############################

output "serverless1" {
    value = aws_rds_cluster.aurora_clusters["cluster_1"]
}