####
#### Basic, Broad Egress to Local VPC
####
resource "aws_security_group" "base-out-vpc" {
  name        = "base-out-vpc"
  description = "Provides base egress to everything in the local VPC"

  tags = merge(local.default-tags, { "Name" = "base-out-vpc" })

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [
	    data.aws_vpc.selected.cidr_block
  	]
  }
}


resource "aws_security_group" "base-in-vpc" {
  name        = "base-in-vpc"
  description = "Provides base inress to everything in the local VPC"

  tags = merge(local.default-tags, { "Name" = "base-in-vpc" })

  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [
		    data.aws_vpc.selected.cidr_block
  	]
  }
}

####
#### Basic, Broad Egress to Internet
#### - Should seldomly be used except for systems potentially accessing all the
#### -- Internet
####
resource "aws_security_group" "base-out-internet" {
  name        = "base-out-internet"
  description = "Provides base egress to the Intarwebs"

  tags = merge(local.default-tags, { "Name" = "base-out-internet" })

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "efs" {
  name        = "base-in-efs-vpc"
  description = "Provides base ingress to the EFS"

  tags = merge(local.default-tags, { "Name" = "base-in-efs-vpc" })

  vpc_id = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [
      data.aws_vpc.selected.cidr_block
    ]
  }
}
