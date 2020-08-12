data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

data "aws_vpc" "selected" {
  default = true
}

data "external" "env" {
  program           = ["jq", "-n", "env"]
}
