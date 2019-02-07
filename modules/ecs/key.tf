resource "aws_key_pair" "ecskeypair" {
  key_name   = "${var.keyname}"
  public_key = "${var.pubkey}"
}
