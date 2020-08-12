# ---------------------------------------------------------------------------------------------------------------------
# Route table for networks
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "public" {
    vpc_id          = aws_vpc.dedicated.id

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = element(split(",",join(",",aws_internet_gateway.main.*.id)),0)
    }

    tags = merge(local.default-tags, { "Name" = "${var.name}-public" })

    lifecycle {
      ignore_changes = [
        route
      ]
    }


}

# ---------------------------------------------------------------------------------------------------------------------
# We create separate route tables for private subnets becuase we have separate nat gateways: 1 per az
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "private" {
    count               = length(aws_nat_gateway.egress.*.id)
    vpc_id              = aws_vpc.dedicated.id

    route {
        cidr_block      = "0.0.0.0/0"
        nat_gateway_id  = aws_nat_gateway.egress.*.id[count.index]
    }

    tags = merge(local.default-tags, { "Name" = "${var.name}-private-${format("%02d", count.index+1)}" })

    lifecycle {
      ignore_changes = [
        route
      ]
    }

}
