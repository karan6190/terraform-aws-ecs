## Provisioning ECS Cluster for Dev Environment 

Configuration in this directory creates the Infrastructure and ECS cluster which may be sufficient for **Dev** or **QA** environment.
It set up the VPC with NAT Gateways, Application Loadblancer with default two Listener and ECS cluster depending on type of Launch type provided.

## Usage

To run this example you need to execute:

```
$ terraform init
$ terraform plan
$ terraform apply

```
Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run **terraform destroy** when you don't need these resources.

## Sample Template

```hcl

## This Template creates the infrastructure
## with bastion host
##

module "main-vpc" {
  source     = "../../modules/vpc"
  ENV        = "${var.ENV}"                    #productEnv
  AWS_REGION = "${var.AWS_REGION}"
  VPC_NAME   = "${var.VPC_NAME}"               #productID
  az1        = "${var.AWS_REGION}a"
  az2        = "${var.AWS_REGION}b"
}

module "bastion" {
  source         = "../../modules/bastion"
  ENV            = "${var.ENV}"
  AWS_REGION     = "${var.AWS_REGION}"
  VPC_NAME       = "${var.VPC_NAME}"                     #productID
  vpc_id         = "${module.main-vpc.vpc_id}"           #productVPC
  public_subnets = "${module.main-vpc.public_subnets-1}"
  keyname        = "bastion-key"                         #Key name
  pubkey         = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxx"     #public key
}

```

```hcl

## This templates creates the Application Loadblancer and 
## setup the ECS Cluster
##

module "alb" {
  source               = "../../modules/loadblancer/application_loadblancer"
  ENV                  = "dev" # Product Environment
  VPC_NAME             = "fusion" # Product Name
  appname              = "ecs-demo" # Application Name
  vpc_id               = "${module.main-vpc.vpc_id}"
  public-subnet-1      = "${module.main-vpc.public_subnets-1}"
  public-subnet-2      = "${module.main-vpc.public_subnets-2}"
  certificate_arn      = "xxxxxxxxxxxxxxxxxxxxxxxx"
}

module "ecs" {
  source               = "../../modules/ecs"
  ENV                  = "dev" # Product Environment
  VPC_NAME             = "fusion" # Product Name
  vpc_id               = "${module.main-vpc.vpc_id}"
  public-subnet-1      = "${module.main-vpc.public_subnets-1}"
  public-subnet-2      = "${module.main-vpc.public_subnets-2}"
  appname              = "ecs-demo" # Application Name
  min_size             = "1" # default 1, Minimum no of Instance node (ASG)
  max_size             = "4" # default 4, Maximum no of Instance node (ASG)
  desired_capacity     = "2" # default 2, number of Amazon EC2 instances that should be running
  keyname              = "ecskey"# key Name
  pubkey               = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # Public key
  instance_type        = "t2.micro" # default t2.micro
  iam_instance_profile = "${module.IAM.instance_profile}"
  applicationPort      = "80" # Application port no (for security group)
  iam_role             = "${module.IAM.iam_role}"
  target_group         = "${module.alb.tagetGroup}"
  container_name       = "demo-ecs-container" # Container Name
  container_port       = "80"
  ecs_task_family      = "nginx" # Task defination name
  container_definitions= "${file("container_definition.json")}"
  desired_count        = "2" # default 1
  launch_type          = "EC2" # valid values are EC2 and FARGATE, default is EC2
  iam_policy_name      = "ecs-policy"     #Policy Name
  iam_instance_profile = "ecs-profile"    # Instance profile Name
  iam_role             = "fusion-dev-ecs" # Role Name
}

```

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| public_subnets-1 | ID of public subnet 1 |
| public_subnets-2 | ID of public subnet 2 |
| private_subnets-1 | ID of private subnet 1 |
| private_subnets-2 | ID of private subnet 2 |
| Loadblancer DNS | DNS name of Loadblancer |