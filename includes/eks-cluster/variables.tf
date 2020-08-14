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
  default = []
}

variable "vpc_id" {}

locals {
  default-tags = {
    provisioner              = "terraform"
  }

}
