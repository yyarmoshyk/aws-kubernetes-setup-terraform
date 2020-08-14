data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
  # filter {
  # 	name   = "tag:Name"
  #   values = ["${var.name} VPC"]
  # }
}

data "external" "env" {
  program           = ["jq", "-n", "env"]
}
