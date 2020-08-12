resource "aws_cloudwatch_log_group" "eks" {
  count             = length(var.cluster_enabled_log_types) > 0 ? 1 : 0
  name              = "/aws/eks/${var.name}-eks-cluster/cluster"
  retention_in_days = 7
}
