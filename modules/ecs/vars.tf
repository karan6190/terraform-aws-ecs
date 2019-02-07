variable "ENV" {
  description = "Type of Environment like Prod, Dev, Staging"
  default     = "dev"
}

variable "VPC_NAME" {
  description = "Product Name"
}

variable "appname" {
  description = "Application Name"
}

variable "vpc_id" {
  description = "Required VPC ID of your Infrastructure"
}

variable "public-subnet-1" {
  description = " Public Subnet 1 ID"
}

variable "public-subnet-2" {
  description = " Public Subnet 2 ID"
}


variable "min_size" {
  description = "Minimum no of Instance node"
  default     = "1"
}

variable "max_size" {
  description = "Maximum no of Instance node"
  default     = "4"
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running"
  default     = "2"
}

variable "keyname" {
  description = "EC2 key name"
}

variable "pubkey" {
  description = "Public key"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}


variable "applicationPort" {
  description = " Application Port"
  default     = "80"
}


variable "target_group" {
  description = "Target Group ARN"
}

variable "container_name" {
  description = "Container Name"
}

variable "container_port" {
  description = "Container port"
}

variable "ecs_task_family" {
  description = "A unique name for your task definition"
}

variable "container_definitions" {
  description = "Container definition"
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  default = "1"
}

variable "launch_type" {
  description = "The launch type on which to run your service. The valid values are EC2 and FARGATE"
  default = "EC2"
}

variable "iam_policy_name" {
  description = "IAM Policy Name"
}

variable "iam_instance_profile" {
  description = " IAM Instance Profile"
}

variable "iam_role" {
  description = " IAM Role Name"
}
