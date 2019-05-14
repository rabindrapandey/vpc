resource "aws_vpc" "tfvpc" {
  cidr_block            = "${var.cidr_block}"
  enable_dns_hostnames  = true

  tags = {
    "Name" = "${var.vpc_tag}"
  }
}

resource "aws_internet_gateway" "tfvpc" {
  vpc_id = "${aws_vpc.tfvpc.id}"
  tags = {
    Name = "${var.igw_name}"
  }
}
