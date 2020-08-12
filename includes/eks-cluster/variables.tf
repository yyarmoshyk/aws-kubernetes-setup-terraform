variable "security_group_ids" {
  type = list
  default = []
}

variable "name" {
}

variable "public" {
  type = bool
  default = false
}

variable "cluster_enabled_log_types" {
  default     = ["api","audit","authenticator","controllerManager","scheduler"]
  description = "A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
}

variable "namespaces" {
  type = list
  default = ["default"]
}

locals {
  region_short = "${substr("${element("${split("-", "${data.aws_region.current.name}")}", 0)}", 0, 1)}${substr("${element("${split("-", "${data.aws_region.current.name}")}", 1)}", 0, 1)}${substr("${element("${split("-", "${data.aws_region.current.name}")}", 2)}", 0, 1)}"

  default-tags = {
    provisioner              = "terraform"
  }

}
