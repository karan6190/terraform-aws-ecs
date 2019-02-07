## ALB
resource "aws_alb" "alb" {
  name            = "${var.appname}-alb"
  subnets         = ["${var.public-subnet-1}", "${var.public-subnet-2}"]
  security_groups = ["${aws_security_group.alb_sg.id}"]
  enable_http2    = "true"
  idle_timeout    = 600
}

resource "aws_alb_listener" "alb_hhtp_listener" {
  load_balancer_arn = "${aws_alb.alb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb-targetGroup.id}"
    type             = "forward"
  }
}

#resource "aws_alb_listener" "alb_https_listener" {
  #load_balancer_arn = "${aws_alb.alb.id}"
  #port              = "443"
  #protocol          = "HTTPS"
  #ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  #certificate_arn   = "${var.certificate_arn}"

  #default_action {
    #target_group_arn = "${aws_alb_target_group.alb-targetGroup.id}"
    #type             = "forward"
  #}
#}

resource "aws_alb_target_group" "alb-targetGroup" {
  name       = "${var.appname}-${var.ENV}"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = "${var.vpc_id}"
  depends_on = ["aws_alb.alb"]

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}
