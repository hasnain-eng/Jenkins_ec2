#Creating EC2 instance
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAYS2NWNMYNAYFXJVS"
  secret_key = "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"
}

resource "aws_instance" "foo" {
  ami           = "ami-05fa00d4c63e32376" # us-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
