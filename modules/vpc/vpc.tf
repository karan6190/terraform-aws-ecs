## This template creates the VPC with 2 public and 2 Private subnets
## with attached Internet gateway and Route table.
##
##

### Internet VPC
resource "aws_vpc" "main-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-vpc"
  }
}

### Subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.az1}"

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-pub1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.az2}"

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-pub2"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.az1}"

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-pri1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.az2}"

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-pri2"
  }
}

### Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-GW"
  }
}

### route tables
resource "aws_route_table" "main-public" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-vpc"
  }
}

### route associations public
resource "aws_route_table_association" "main-public-route-1" {
  subnet_id      = "${aws_subnet.public-subnet-1.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = "${aws_subnet.public-subnet-2.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}
