resource "aws_iam_role" "eks-node" {
  description        = "Amazon EKS - Node Group Role."

  name               = "${local.name_prefix}-node-role"
  path               = local.iam_path
  assume_role_policy = data.aws_iam_policy_document.node-assume-policy.json

  tags = merge(local.default-tags, { "Name" = "${local.name_prefix}-node-role" })
}

resource "aws_iam_instance_profile" "eks-node" {
  name = "${local.name_prefix}-node"
  role = aws_iam_role.eks-node.name

  depends_on = [
    aws_iam_role.eks-node
  ]
}


resource "aws_iam_role_policy_attachment" "WorkerNodePolicy" {
  role       = aws_iam_role.eks-node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  depends_on = [
    aws_iam_role.eks-node
  ]
}

resource "aws_iam_role_policy_attachment" "CNIPolicy" {
  role       = aws_iam_role.eks-node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  depends_on = [
    aws_iam_role.eks-node
  ]
}

resource "aws_iam_role_policy_attachment" "ContainerRegistryReadOnly" {
  role       = aws_iam_role.eks-node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  depends_on = [
    aws_iam_role.eks-node
  ]
}
