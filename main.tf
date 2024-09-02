#Creating EC2 instance
provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "testserver" {
  ami           = "ami-04df9ee4d3dfde202"
  instance_type = "t2.small"
  key_name      = aws_key_pair.keypair.key_name
  tags = {
  Name          = "Made via terraform"
  vpc_security_group_ids = "${aws_security_group.terraform_security_group.id}"
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "test-key"
  public_key = file("${path.module}/public key")
}

resource "aws_security_group" "terraform_security_group" {
  name        = "my-sg"
  description = "My custom security group created through terraform"

  dynamic "ingress" {
    for_each = [3389, 80, 22, 443, 3306]
    iterator = port
    content {
      description = "Rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#Create aws load balancer

resource "aws_lb" "app_lb" {
  name               = "app_lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terraform_security_group.id]
  subnets            = ["subnet-0b41a4de29656edb1", "subnet-09d8da5cdbcb8aad0"]

  enable_deletion_protection = false
}


