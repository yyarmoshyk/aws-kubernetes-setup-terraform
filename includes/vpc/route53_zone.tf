resource "aws_route53_zone" "primary" {
  name = "${var.name}.internal"

  vpc {
    vpc_id = aws_vpc.dedicated.id
  }

}
