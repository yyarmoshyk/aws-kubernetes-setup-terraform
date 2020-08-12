resource "aws_security_group" "custom" {
  name        = local.name_prefix
  description = "The custom security group for ${local.name_prefix} in default VPC"

  vpc_id = data.aws_vpc.selected.id

  tags = merge(local.default-tags, { "Name" = "${local.name_prefix}" })

  dynamic "ingress" {
    for_each = var.ingress_tcp_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [
        var.nework_cidr
      ]
    }
  }

  dynamic "egress" {
    for_each = var.egress_tcp_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = [
        var.nework_cidr
      ]
    }
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }


  lifecycle {
    ignore_changes = [
      name,
    ]
  }

}
