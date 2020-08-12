locals {
  default_subnet_ids_string     = join(",", data.aws_subnet_ids.default.ids)
  default_subnet_ids_list       = split(",", local.default_subnet_ids_string)
}

resource "aws_eks_cluster" "cluster" {
  name     = "${var.name}-eks-cluster"
  role_arn = data.aws_iam_role.eks-service-role.arn

  enabled_cluster_log_types = var.cluster_enabled_log_types

  vpc_config {
    # endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids              = slice(local.default_subnet_ids_list,0,2)

    # security groups to apply to the EKS-managed Elastic Network Interfaces that are created in your worker node subnets
    security_group_ids      = [
      data.aws_security_group.service.id
    ]

  }

  tags = merge(local.default-tags, { "Name" = "${var.name}-eks-cluster" })

  depends_on = [
    aws_cloudwatch_log_group.eks
  ]
}

output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.cluster.certificate_authority.0.data
}

output "name" {
  value = "${var.name}-eks-cluster"
}
