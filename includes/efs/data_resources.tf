data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  filter {
    name   = "tag:type"
    values = [
      var.network_type
    ]
  }

}
data "aws_caller_identity" "current" {}

locals {
  private_subnet_ids_string          = join(",", data.aws_subnet_ids.private.ids)
  private_subnet_ids_list            = split(",", local.private_subnet_ids_string)
}

data "aws_subnet" "private" {
  count = "${length(data.aws_subnet_ids.private.ids)}"
  id = "${local.private_subnet_ids_list[count.index]}"
}
