#Creating EC2 instance
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAYS2NWNMYNAYFXJVS"
  secret_key = "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"
}

resource "aws_instance" "testserver" {
  ami           = "ami-04df9ee4d3dfde202"
  instance_type = "t2.micro"
  tags = {
  Name          = "Made via terraform"
    }
}
