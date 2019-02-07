## This Template creates the infrastructure
## with bastion host
##

module "main-vpc" {
  source     = "/modules/vpc"
  ENV        = "${var.ENV}"         #productEnv
  AWS_REGION = "${var.AWS_REGION}"
  VPC_NAME   = "${var.VPC_NAME}"    #productID
  az1        = "${var.AWS_REGION}a"
  az2        = "${var.AWS_REGION}b"
}

module "bastion" {
  source         = "/modules/bastion"
  ENV            = "${var.ENV}"
  AWS_REGION     = "${var.AWS_REGION}"
  VPC_NAME       = "${var.VPC_NAME}"                     #productID
  vpc_id         = "${module.main-vpc.vpc_id}"           #productVPC
  public_subnets = "${module.main-vpc.public_subnets-1}"
  keyname        = "bastion-key"                         #Key Name
  pubkey         = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxxxxxx" # Public key
}
