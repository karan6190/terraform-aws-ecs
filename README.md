Terraform module which Setup the ECS cluster with desired Launch type i.e., **EC2 or FARGATE**.

These types of resources are supported:

* [VPC](https://www.terraform.io/docs/providers/aws/r/vpc.html)
* [Subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
* [Route](https://www.terraform.io/docs/providers/aws/r/route.html)
* [Route table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
* [Internet Gateway](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html)
* [NAT Gateway](https://www.terraform.io/docs/providers/aws/r/nat_gateway.html)
* [Bastion Host](https://www.terraform.io/docs/providers/aws/r/instance.html)
* [Application Loadblancer](https://www.terraform.io/docs/providers/aws/r/lb.html)
* [Elastic Container Services](https://www.terraform.io/docs/providers/aws/r/ecs_service.html)

## VPC 
By default this modules creates the **VPC** with **two public subnets** and **two private subnets** with **NAT gateways on each Private subnets**.
**Internet Gateway** is associated with public Subnets.

```hcl

module "main-vpc" {
  source     = "https://github.com/karan6190/terraform-aws-ecs/tree/master/modules/vpc"
  ENV        = "${var.ENV}"                  #productEnv
  AWS_REGION = "${var.AWS_REGION}"
  VPC_NAME   = "${var.VPC_NAME}"             #productID
  az1        = "${var.AWS_REGION}a"
  az2        = "${var.AWS_REGION}b"
}

```
## Bastion Host
Bastion host helps us to Jump into the Instances in the private subnets.
So this module launches the Instance in the public subnet which act as a jump server.
By default Bastion host is launched with attached **Administrative access policy** and **Security group (to access it over SSH)**

```hcl
module "bastion" {
  source         = "https://github.com/karan6190/terraform-aws-ecs/tree/master/modules/bastion"
  ENV            = "${var.ENV}"
  AWS_REGION     = "${var.AWS_REGION}"
  VPC_NAME       = "${var.VPC_NAME}"                     #productID
  vpc_id         = "${module.main-vpc.vpc_id}"           #productVPC
  public_subnets = "${module.main-vpc.public_subnets-1}"
  keyname        = "bastion-key"                         #Key name
  pubkey         = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxx"     #public key
}

```

## ECS
This module launch up the cluster with user defined **Launch Type** like **EC2** or **FARGATE** with attached
**Application Loadblancer** to send service on your behalf.

```hcl
module "ecs" {
  source               = "https://github.com/karan6190/terraform-aws-ecs/tree/master/modules/ecs"
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
  applicationPort      = "80" # Application port no (for security group)
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

## ALB
This module set the **Loadblancer** with designed **Target Group**. By default it will launch up the two Listeners
one on 80 port and Other one on 443 port with attached SSL certificate.

```hcl
module "alb" {
  source               = "https://github.com/karan6190/terraform-aws-ecs/tree/master/modules/loadblancer/application_loadblancer"
  ENV                  = "dev" # Product Environment
  VPC_NAME             = "fusion" # Product Name
  appname              = "ecs-demo" # Application Name
  vpc_id               = "${module.main-vpc.vpc_id}"
  public-subnet-1      = "${module.main-vpc.public_subnets-1}"
  public-subnet-2      = "${module.main-vpc.public_subnets-2}"
  certificate_arn     = "xxxxxxxxxxxxxxxxxxxxxxxx"
}

```

## Examples

* [ECS for dev Environment](https://github.com/karan6190/terraform-aws-ecs/tree/master/examples/ecs-dev)
* [ECS for prod Environment](https://github.com/karan6190/terraform-aws-ecs/tree/master/examples/ecs-prod)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ENV | Infrastructure Environment | String | dev | no |
| VPC_NAME | Infrastructure Name | String | Demo-dev | no |
| pubkey | Key which is to associate with bastion host | String | " " | yes |
| Application Name | Name for your Application to be deployed in Cluster | String | " " | yes
| Launch Type | Cluster Launch type i.e. EC2 or FARGATE | String | EC2 | no |
| SSL Certificate | SSL Certificate ARN | String | " " | yes |


## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| public_subnets-1 | ID of public subnet 1 |
| public_subnets-2 | ID of public subnet 2 |
| private_subnets-1 | ID of private subnet 1 |
| private_subnets-2 | ID of private subnet 2 |
| Loadblancer DNS | DNS name of Loadblancer |

## Authors

Module is maintained by [Karan Sharma](https://github.com/karan6190).

## License

Apache 2 Licensed. See LICENSE for full details.


