## This Template creates the bastion host for
## ssh into the instances present in the private
## subnets

### AWS linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

### creaing Bastion host
resource "aws_instance" "bastion" {
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${var.public_subnets}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  iam_instance_profile = "${aws_iam_instance_profile.bastion_profile.name}" #Administrative Access

  tags {
    Name = "Bastion-${var.VPC_NAME}-${var.ENV}-host"
  }
}
