resource "aws_key_pair" "mykeypair" {
  key_name   = "${var.keyname}"
  public_key = "${var.pubkey}"
}
