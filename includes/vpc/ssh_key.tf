resource "aws_key_pair" "generic" {
  key_name   = "${var.name}-key"
  public_key = var.public_key
}
