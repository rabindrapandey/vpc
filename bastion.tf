resource "aws_launch_configuration" "bastion" {
  name_prefix = "bastion-"
  image_id = "${data}"
}
