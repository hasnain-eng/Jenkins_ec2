
#Creating EC2 instance
provider "aws" {
  region     = "us-east-1"
  }
resource "aws_instance" "testserver" {
  ami           = "ami-04df9ee4d3dfde202"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.keypair.key_name
  tags = {
  Name          = "Made via terraform"
  vpc_security_group_ids = "${aws_security_group.terraform_security_group.id}"
  }
 }

output "securitygroupDetails" {
  value = aws_security_group.terraform_security_group.id
}


