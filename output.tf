##Output of the designed INFRA

output "vpc_id" {
  value       = "${module.main-vpc.vpc_id}"
  description = "Designed VPC ID"
}

output "public_subnets-1" {
  value       = "${module.main-vpc.public_subnets-1}"
  description = "ID of Public subnet 1"
}

output "public_subnets-2" {
  value       = "${module.main-vpc.public_subnets-2}"
  description = "ID of Public subnet 2"
}

output "private_subnets-1" {
  value       = "${module.main-vpc.private_subnets-1}"
  description = "ID of Private subnet 1"
}

output "private_subnets-2" {
  value       = "${module.main-vpc.private_subnets-2}"
  description = "ID of Private subnet 2"
}

output "alb_dns" {
  value = "${module.alb.alb_dns}"
  description = "DNS name of Application Loadblancer"
}
