variable "region" {
  type = "string"
}
variable "vpc_tag" {
  type = "string"
}
variable "igw_name" {
  type = "string"
}
variable cidr_block {
    type        = "string"
    description = "PVC Cidr Block. Example: 10.0.0.0/16"
}
variable "environment" {
  type = "string"
}
variable "availability_zones" {
  type = "list"
}
variable "bast_instance_type" {
  type = "string"
  
}
variable "pub_dest_cidr" {
  type = "string"
  
}

variable "aws_key_name" {
  type = "string"
  
}

