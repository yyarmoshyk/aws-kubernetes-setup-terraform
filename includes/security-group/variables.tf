variable "ingress_tcp_ports" {
  description = "The list of ports to open from provided address"
  type = list
  default = []
}

variable "egress_tcp_ports" {
  description = "The list of ports to open to provided address"
  type = list
  default = []
}

variable "nework_cidr" {
  description = "The network mask to open local ports"
  default = "0.0.0.0/0"
}

variable "name" {
  description = "The application name tfor the cluster"
}


variable "protocol" {
  default = "tcp"
}

variable "vpc_id" {}

locals {
  name_prefix                 = "${var.name}-custom"

  default-tags = {
    provisioner               = "terraform"
  }

}
