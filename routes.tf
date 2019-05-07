# Route table to allow traffic to internet through the internet
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.tfvpc.id}"
  tags = {
      "Name" = "PubRouteTbl"
  }
}

resource "aws_route" "public_internet_gateway" {
    route_table_id          = "${aws_route_table.public.id}"
    destination_cidr_block  = "${var.pub_dest_cidr}"
    gateway_id              = "${aws_internet_gateway.tfvpc.id}"

}

resource "aws_route_table_association" "public" {
    count           = "${length(var.availability_zones)}"
    subnet_id       = "${element(aws_subnet.public.*.id, count.index)}" 
    route_table_id  = "${aws_route_table.public.id}"
}

# Private Route table to allow traffic internally and also through
# NAT/Proxy Server

resource "aws_route_table" "private" {
    vpc_id  = "${aws_vpc.tfvpc.id}"
    tags    = {
        Name = "PrivRouteTbl"
    }
}

resource "aws_route_table_association" "private" {
    count           = "${length(var.availability_zones)}"
    subnet_id       = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id  = "${aws_route_table.private.id}"
  
}

