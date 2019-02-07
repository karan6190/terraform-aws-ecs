### Taking the output of the bastion-SG and designed Role

output "bastion-SG" {
  description = "ID of bastion Security Group"
  value       = "${aws_security_group.allow-ssh.id}"
}

output "instance_profile" {
  description = "Default instance profile of EC2"
  value       = "${aws_iam_instance_profile.bastion_profile.name}"
}
