###########################
# Public Subnets
# Each subnet in a diff AZ
###########################
resource "aws_subnet" "public" {
  count                     = "${length(var.availability_zones)}"
  vpc_id                    = "${aws_vpc.tfvpc.id}"
  cidr_block                = "${cidrsubnet(var.cidr_block, 8, count.index)}"
  availability_zone         = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch   = true
  tags = {
      "Name" = "pubSubnet-${element(var.availability_zones, count.index)}"
  }
}

resource "aws_subnet" "private" {
    count                   = "${length(var.availability_zones)}"
    vpc_id                  = "${aws_vpc.tfvpc.id}"
    cidr_block              = "${cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones))}"
    availability_zone       = "${element(var.availability_zones, count.index)}"

    tags = {
        Name    = "privSubnet-${element(var.availability_zones, count.index)}"
    }
}
