data "aws_iam_policy_document" "service-assume-policy" {
  statement {
    effect = "Allow"
    sid = "allowassume"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}
