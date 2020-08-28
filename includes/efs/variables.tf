variable "network_type" {
  type = string
  default = "private"
}

variable "name" {}

variable "security_group_ids" {
  default = []
}

variable "backup" {
  default = false
}

variable "vpc_id" {}

locals {
  default-tags = {
    provisioner               = "terraform"
  }

}
