resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.name}-node-group"
  node_role_arn   = data.aws_iam_role.eks-node-role.arn
  # subnet_ids      = var.public ? data.aws_subnet_ids.public.ids : data.aws_subnet_ids.nat.ids
  subnet_ids      = data.aws_subnet_ids.private.ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  remote_access {
    # ec2_ssh_key = "ppt_id_rsa"
    ec2_ssh_key = "${var.name}-key"

    source_security_group_ids = [
      data.aws_security_group.base-out-vpc.id
    ]
  }

  tags = merge(local.default-tags, { "Name" = "${var.name}-node-group" })
}
