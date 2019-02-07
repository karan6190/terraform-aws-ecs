## This Template creates the Default security group and 
## will be attached to bastion host

## Creating security Group

resource "aws_security_group" "allow-ssh" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.VPC_NAME}-bastion-${var.ENV}-SG"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.VPC_NAME}-bastion-${var.ENV}-SG"
  }
}
