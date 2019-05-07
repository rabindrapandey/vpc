#AWS
data "aws_ami" "amazon_linux" {
    most_recent = true
    filter {
        name    = "name"
        values  = ["amzn-ami-*"-]
    }
  
}
