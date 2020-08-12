locals {
  cidr_endings = {
    public      = [
      "1.0/24",
      "2.0/24",
      "3.0/24",
    ]
    private     = [
      "32.0/19",
      "64.0/19",
      "96.0/19",
    ]
  }
  region_short = "${substr("${element("${split("-", "${data.aws_region.current.name}")}", 0)}", 0, 1)}${substr("${element("${split("-", "${data.aws_region.current.name}")}", 1)}", 0, 1)}${substr("${element("${split("-", "${data.aws_region.current.name}")}", 2)}", 0, 1)}"

  default-tags = {
    provisioner               = "terraform"
  }

}

variable "cidr_block" {
  description = "The range of IPv4 addresses for your VPC in CIDR block format, for example, 10.0.0.0/24. Block sizes must be between a /16 netmask and /28 netmask."
}

variable "num_subnets" {
  default = 1
}

variable "name" {}
