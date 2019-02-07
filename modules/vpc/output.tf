### Taking the output of the designed VPC and Subnets
output "vpc_id" {
  description = "designed VPC ID"
  value       = "${aws_vpc.main-vpc.id}"
}

output "public_subnets-1" {
  description = "ID of Public subnet 1"
  value       = "${aws_subnet.public-subnet-1.id}"
}

output "public_subnets-2" {
  description = "ID of Public subnet 2"
  value       = "${aws_subnet.public-subnet-2.id}"
}

output "private_subnets-1" {
  description = "ID of Private subnet 1"
  value       = "${aws_subnet.private-subnet-1.id}"
}

output "private_subnets-2" {
  description = "ID of Private subnet 2"
  value       = "${aws_subnet.private-subnet-2.id}"
}

output "internetgateway" {
  description = "ID of IinternetGateway"
  value       = "${aws_internet_gateway.main-gw.id}"
}
