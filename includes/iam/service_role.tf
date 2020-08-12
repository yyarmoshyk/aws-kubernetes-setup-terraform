resource "aws_iam_role" "eks-service" {
  description        = "The role that Amazon EKS will use to create AWS resources for Kubernetes clusters."

  name               = "${local.name_prefix}-service-role"
  path               = local.iam_path
  assume_role_policy = data.aws_iam_policy_document.service-assume-policy.json

  tags = merge(local.default-tags, { "Name" =  "${local.name_prefix}-service-role" })
}

resource "aws_iam_role_policy_attachment" "ServicePolicy" {
  role       = aws_iam_role.eks-service.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  depends_on = [
    aws_iam_role.eks-service
  ]
}

resource "aws_iam_role_policy_attachment" "ClusterPolicy" {
  role       = aws_iam_role.eks-service.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  depends_on = [
    aws_iam_role.eks-service
  ]
}
