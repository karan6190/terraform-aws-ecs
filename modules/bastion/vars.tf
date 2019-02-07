variable "AWS_REGION" {
  description = "Region where you have to Provision Infrastructure"
  default     = "us-east-1"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-0ff8a91507f77f867"
    us-east-2 = "ami-0b59bfac6be064b78"
    us-west-1 = "ami-a0cfeed8"
    us-west-2 = "ami-0bdb828fd58c52235"
  }
}

variable vpc_id {
  description = "Designed VPC ID"
}

variable public_subnets {
  description = "ID of Public subnet"
}

variable "ENV" {
  description = "Type of Environment like Prod, Dev, Staging"
  default     = "dev"
}

variable "VPC_NAME" {
  description = "Name of the Product"
}

variable "pubkey" {
  description = "Public key to be associated with bastion host"
}

variable "keyname" {
  description = "Name of the public key"
}
