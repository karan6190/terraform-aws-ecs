## This template creates the instance profile
##

### IAM Instance profile
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion_profile"
  role = "${aws_iam_role.bastion_role.name}"
}
