## Taking the output of the designed Application loadblancer
##

output "alb_dns" {
  value = "${aws_alb.alb.dns_name}"
}

output "tagetGroup" {
  value = "${aws_alb_target_group.alb-targetGroup.arn}"
}
