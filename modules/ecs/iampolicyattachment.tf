## This template will attach the designed policy to a defined Role

##Policy attachment
resource "aws_iam_policy_attachment" "policy-attachment" {
  name       = "policy-attachment"
  roles       = ["${aws_iam_role.ec2_role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}
