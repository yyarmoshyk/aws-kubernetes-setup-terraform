module "vpc" {
  source              = "./includes/vpc/"
  name                = "sample-eks"
  cidr_block          = "172.100.0.0/16"
  num_subnets         = 2

  public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLokz3Vp+IFMZDwHkAIw++ktbvtEQ71VqwE+pYnj3aqYtBtm+gKedxTr4LQXDiN55jZtM0sNKBq/TNnBoxqJuVYMna4jxpz0MKMbQZ8i/SQo0d3RgZASbFIdmF3J7cVvXyAAzYbRyzlspxn2dqCoJp656mYgObmMQDOQMKeuQALoMgvJYkiWIbIaXItb9NjR6zjytx6B4+PCcMKMr31lLiomK3HyewSFrfTIWil3Na/uuwHLPFf2/qT7lNRREYFobRHT+oAqM/Fhl8q6cvc6qRuCZ5kW4z0OASptQnniAQPIxxiU+6oti23iPHc3E7+cBZc6ByE0wq/j1stlyj17kp public@key"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

module "eks-iam" {
  source              = "./includes/iam/"
  name                = "sample-eks"
}

module "eks-sg" {
  source              = "./includes/security-group/"
  name                = "sample-eks"

  vpc_id              = module.vpc.vpc_id

  nework_cidr         = "0.0.0.0/0"
  egress_tcp_ports    = ["0"]
  protocol            = "-1"

}

module "eks-efs" {
  source              = "./includes/efs/"
  name                = "sample-eks"

  vpc_id              = module.vpc.vpc_id
  security_group_ids  = [module.eks-sg.efs_security_group_id]
  network_type        = "private"
}

output "eks_efs_id" {
  value = module.eks-efs.efs_id
}

module "eks-sample-cluster" {
  source              = "./includes/eks-cluster/"
  name                = "sample-eks"
  vpc_id              = module.vpc.vpc_id

  # The one can create separate fargate profiles for each namespace
  # namespaces          = ["default","monitoring","service"]
}
