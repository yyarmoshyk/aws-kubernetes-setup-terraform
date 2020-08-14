data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

# data "aws_vpc" "selected" {
#   filter {
#   	name   = "tag:Name"
#     values = ["${var.name} VPC"]
#   }
# }

data "aws_subnet_ids" "public" {
  vpc_id = var.vpc_id

  filter {
    name   = "tag:type"
    values = ["public"]
  }

}

data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  filter {
    name   = "tag:type"
    values = ["private"]
  }

}

data "aws_iam_role" "eks-service-role" {
  name = "eks-${var.name}-service-role"
}

data "aws_iam_role" "eks-node-role" {
  name = "eks-${var.name}-node-role"
}

data "aws_security_group" "service" {
  vpc_id = var.vpc_id
  name = "${var.name}-custom"
}

data "aws_security_group" "base-out-vpc" {
  vpc_id = var.vpc_id
  name = "base-out-vpc"
}
