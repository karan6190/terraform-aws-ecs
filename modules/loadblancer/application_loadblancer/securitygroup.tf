## This template creates the Security group for Application loadblancer
##

###Application loadblancer security Group
resource "aws_security_group" "alb_sg" {
  description = "controls access to the application ELB"

  vpc_id = "${var.vpc_id}"
  name   = "${var.appname}-${var.ENV}-alb_sg"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
