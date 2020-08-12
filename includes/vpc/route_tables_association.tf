# ---------------------------------------------------------------------------------------------------------------------
# Route association for networks
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_route_table_association" "public" {
    count           = length(aws_subnet.public.*.id)
    subnet_id       = aws_subnet.public.*.id[count.index]
    route_table_id  = aws_route_table.public.id
    depends_on      = [
      aws_route_table.public,
      aws_subnet.public
    ]
}

resource "aws_route_table_association" "private" {
    count           = length(aws_subnet.private.*.id)
    subnet_id       = aws_subnet.private.*.id[count.index]
    route_table_id  = aws_route_table.private.*.id[count.index]
    depends_on      = [
      aws_route_table.private,
      aws_subnet.private
    ]
}
