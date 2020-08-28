resource "aws_efs_file_system" "efs" {
  creation_token    = "${var.name}-efs"

  tags              = merge(local.default-tags, { "Name" = "${var.name}-efs" })

  lifecycle {
    ignore_changes  = [
      creation_token,
    ]
  }

}

resource "aws_efs_mount_target" "private" {
  count           = length(data.aws_subnet_ids.private.ids)

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = local.private_subnet_ids_list[count.index]

  security_groups = var.security_group_ids
}
