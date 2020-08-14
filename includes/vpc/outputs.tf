output "vpc_id" {
  value = aws_vpc.dedicated.id
}

output "cidr_block" {
  value = aws_vpc.dedicated.cidr_block
}

output "private_route_table_ids" {
  value = aws_route_table.private.*.id
}

output "public_route_table_ids" {
  value = aws_route_table.public.*.id
}
