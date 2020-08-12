data "aws_iam_policy_document" "node-assume-policy" {
  statement {
    effect = "Allow"
    sid = "allowassume"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
