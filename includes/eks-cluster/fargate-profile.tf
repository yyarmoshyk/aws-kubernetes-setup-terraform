resource "aws_eks_fargate_profile" "fargate_profile" {
  count                  = length(var.namespaces)
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "${var.namespaces[count.index]}-namespace"
  pod_execution_role_arn = data.aws_iam_role.eks-node-role.arn
  subnet_ids             = local.private_subnet_ids_list

  selector {
    namespace = var.namespaces[count.index]
  }
}
