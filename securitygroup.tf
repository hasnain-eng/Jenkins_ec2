#Creating Security Group
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