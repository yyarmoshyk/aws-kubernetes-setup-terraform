output "security_group_id" {
  value = aws_security_group.custom.id
}

output "efs_security_group_id" {
  value = aws_security_group.efs.id
}
