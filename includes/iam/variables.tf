locals {
  name_prefix = "eks-${var.name}"
  iam_path = "/"

  default-tags = {
    provisioner              = "terraform"
  }

}

variable "name" {
  description = "The application name for the cluster"
}
