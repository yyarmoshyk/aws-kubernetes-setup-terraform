# ---------------------------------------------------------------------------------------------------------------------
# nat gateway for private subnets
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_eip" "egress" {
  count         = length(aws_subnet.public.*.id)
  vpc           = true

  tags = merge(local.default-tags, { "Name" = "${var.name}-eip-${format("%02d", count.index+1)}" })
}

resource "aws_nat_gateway" "egress" {
  count = length(aws_eip.egress.*.id)

  allocation_id = aws_eip.egress.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]

  tags = merge(local.default-tags, { "Name" = "${var.name}-nat-gw-${format("%02d", count.index+1)}" })

  depends_on    = [
    aws_vpc.dedicated,
    aws_eip.egress,
    aws_subnet.public
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# internet gateway for public subnets
# This is a special aWS resource that can be one per VPC
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "main" {
  vpc_id        = aws_vpc.dedicated.id

  tags = merge(local.default-tags, { "Name" = "${var.name}-igw" })

  depends_on    = [
    aws_vpc.dedicated,
    aws_eip.egress
  ]
}
