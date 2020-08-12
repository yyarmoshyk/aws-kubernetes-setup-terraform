data "aws_availability_zones" "available" {}

data "aws_availability_zone" "all-in-one" {
  count = length(data.aws_availability_zones.available.zone_ids)
  zone_id = data.aws_availability_zones.available.zone_ids[count.index]
}

data "aws_region" "current" {}

data "external" "env" {
  program           = ["jq", "-n", "env"]
}
