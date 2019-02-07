## VPC

Configuration in this module creates set of VPC resources.

It will create **Two public and private subnets, Two NAT Gateways per Private subnets with Attached EIP, Internet Gateways, Route table**.

## Defining the Module in *main.tf*

```hcl

module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = "${var.ENV}"                    #productEnv
  AWS_REGION = "${var.AWS_REGION}"
  VPC_NAME   = "${var.VPC_NAME}"               #productID
  az1        = "${var.AWS_REGION}a"            # Availability Zone a
  az2        = "${var.AWS_REGION}b"            # Availability Zone b
}

```
By default VPC module will provision all the VPC resources with a name {VPC_NAME}-{dev}-{RESOURCE_NAME}.So that it will be convenient to get the required
RESOURCES at the time of deployment among bunch of RESOURCES.
This module will automatically Tag each and every Provision Resource with its Description just to make it short and simple.

## Directory Structure

- Development
  - main.tf
  - vars.tf
  - provider.tf
  - output.tf
- modules
  - vpc
  - bastion
- Production
  - main.tf
  - vars.tf
  - provider.tf
  - output.tf

## Usage

To run this main.tf you need to execute:

```
$ terraform init
$ terraform plan
$ terraform apply

```