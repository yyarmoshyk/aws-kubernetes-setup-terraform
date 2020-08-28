resource "aws_backup_vault" "efs" {
  count       = var.backup ? 1 : 0
  name        = "${var.name}-backup-vault"

  tags        = merge(local.default-tags, { "Name" = "${var.name}-backup-vault" })

  lifecycle {
    ignore_changes = [
      name,
    ]
  }

}

resource "aws_backup_plan" "efs" {
  count = var.backup ? 1 : 0
  name = "${var.name}-backup-plan"

  rule {
    rule_name         = "${var.name}-rule"
    target_vault_name = aws_backup_vault.efs.*.name[count.index]
    schedule          = "cron(0 12 * * ? *)"
  }

  tags = merge(local.default-tags, { "Name" = "${var.name}-backup-plan" })

  lifecycle {
    ignore_changes = [
      name,
    ]
  }

}

resource "aws_backup_selection" "efs" {
  count        = var.backup ? 1 : 0
  iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/service-role/AWSBackupDefaultServiceRole"
  name         = "${var.name}-backup"
  plan_id      = aws_backup_plan.efs.*.id[count.index]

  resources = [
    aws_efs_file_system.efs.arn
  ]

  lifecycle {
    ignore_changes = [
      name,
    ]
  }

}
