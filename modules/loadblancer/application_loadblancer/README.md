## ALB

Configuration in this module creates Application Loadblancer.
It creates the Loadblancer with default two listener one on 80 port and another one on 443 port.

## Defining the Module in *main.tf*

```hcl

module "alb" {
  source               = "../modules/loadblancer/application_loadblancer"
  ENV                  = "dev" # Product Environment
  VPC_NAME             = "fusion" # Product Name
  appname              = "ecs-demo" # Application Name
  vpc_id               = "${module.main-vpc.vpc_id}"
  public-subnet-1      = "${module.main-vpc.public_subnets-1}"
  public-subnet-2      = "${module.main-vpc.public_subnets-2}"
  certificate_arn      = "xxxxxxxxxxxxxxxxxxxxxxxx"
}

```

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