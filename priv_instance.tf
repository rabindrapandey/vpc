# Create Instance in Private subnet

resource "aws_launch_configuration" "privInstance" {
  name_prefix   =   "priv"
  image_id                    = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "${var.bast_instance_type}"
  key_name                    = "${aws_key_pair.bastion.key_name}"
  associate_public_ip_address = false
  enable_monitoring           = false
  security_groups             = ["${aws_security_group.bastion.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "priv" {
  name                      = "priv-asg"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  health_check_type         = "EC2"
  launch_configuration      = "${aws_launch_configuration.privInstance.name}"
  vpc_zone_identifier       = ["${aws_subnet.private.*.id}"]
}

resource "aws_security_group" "privInstSG" {
  name_prefix = "Private SG"
  description = "Allow all traffic from Bastion Host"
  vpc_id      = "${aws_vpc.tfvpc.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_all_ssh_priv" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = ["${aws_subnet.public.*.cidr_block}"] 
  cidr_blocks       = ["${aws_subnet.private.*.id}"]
  security_group_id = "${aws_security_group.privInstSG.id}"
}

resource "aws_security_group_rule" "allow_all_http_priv" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.public.*.cidr_block}"]
  security_group_id = "${aws_security_group.privInstSG.id}"
}

resource "aws_security_group_rule" "allow_all_https_priv" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.public.*.cidr_block}"]
  security_group_id = "${aws_security_group.privInstSG.id}"
}