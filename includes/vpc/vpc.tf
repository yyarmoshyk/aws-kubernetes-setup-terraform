resource "aws_vpc" "dedicated" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge( local.default-tags, { "Name" = "${var.name} VPC" } )

}
