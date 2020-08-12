# ---------------------------------------------------------------------------------------------------------------------
# Create subnet with specified parametres
# Need one public and private subnet in every availability zone of the region
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "public" {
    count             = length(data.aws_availability_zones.available.names) < var.num_subnets ? length(data.aws_availability_zones.available.names) : var.num_subnets
    vpc_id            = aws_vpc.dedicated.id
    availability_zone = data.aws_availability_zones.available.names[count.index]
    # cidr_block        = "${element(split(".", var.cidr_block), 0)}.${element(split(".", var.cidr_block), 1)}.${element(split(".", var.cidr_block), 2) + (count.index) }.0/24"
    cidr_block        = "${element(split(".", var.cidr_block), 0)}.${element(split(".", var.cidr_block), 1)}.${element(local.cidr_endings["public"], count.index)}"

    tags = merge(
      local.default-tags,
      { "Name" = "${var.name}-public-${replace(element(data.aws_availability_zones.available.names, count.index), "/([a-z]+-)+/", "")}" },
      { "type" = "public"},
      { "kubernetes.io/cluster/${var.name}-eks-cluster" = "shared"}
    )

    depends_on        = [
      aws_vpc.dedicated
    ]
}

resource "aws_subnet" "private" {
    count             = length(data.aws_availability_zones.available.names) < var.num_subnets ? length(data.aws_availability_zones.available.names) : var.num_subnets
    vpc_id            = aws_vpc.dedicated.id
    availability_zone = data.aws_availability_zones.available.names[count.index]
    cidr_block        = "${element(split(".", var.cidr_block), 0)}.${element(split(".", var.cidr_block), 1)}.${element(local.cidr_endings["private"], count.index)}"

    tags = merge(
      local.default-tags,
      { "Name" = "${var.name}-private-${replace(element(data.aws_availability_zones.available.names, count.index), "/([a-z]+-)+/", "")}" },
      { "type" = "private"},
      { "kubernetes.io/cluster/${var.name}-eks-cluster" = "shared"}
    )

    depends_on        = [
      aws_vpc.dedicated,
      aws_subnet.public
    ]
}
