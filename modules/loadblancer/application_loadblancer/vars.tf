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

#variable "certificate_arn" {
  #description = " SSL certificate arn "
#}
