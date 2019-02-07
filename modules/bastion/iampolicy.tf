## This templates creates the IAM policy

###IAM Policy
resource "aws_iam_policy" "bastion-policy" {
  name        = "default-bastionpolicy"
  description = "bastion default policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}
