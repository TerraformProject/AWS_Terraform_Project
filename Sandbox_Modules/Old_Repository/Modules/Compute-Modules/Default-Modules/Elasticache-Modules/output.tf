#################################
## Elasticache Cluster Outputs ##
#################################

output "cluster_1" {
  value = aws_elasticache_cluster.elasticache_clusters["cluster_1"]
}