data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

data "aws_vpc" "selected" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.selected.id
}

data "aws_iam_role" "eks-service-role" {
  name = "eks-${var.name}-service-role"
}

data "aws_iam_role" "eks-node-role" {
  name = "eks-${var.name}-node-role"
}

data "aws_security_group" "service" {
  vpc_id = data.aws_vpc.selected.id
  name = "${var.name}-custom"
}

data "aws_security_group" "base-out-vpc" {
  vpc_id = data.aws_vpc.selected.id
  name = "base-out-vpc"
}
