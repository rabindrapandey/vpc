output "vpc_id" {
  value = "${aws_vpc.tfvpc.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.private.*.id}"
}

output "private_cidrs" {
  value = "${aws_subnet.private.*.cidr_block}"
}
