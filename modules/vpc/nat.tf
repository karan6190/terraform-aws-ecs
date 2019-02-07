## This Template creates the NAT gateway and Route table
##
##

### nat gateway
resource "aws_eip" "nat-eip-1" {
  vpc = true
}

resource "aws_eip" "nat-eip-2" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw-1" {
  allocation_id = "${aws_eip.nat-eip-1.id}"
  subnet_id     = "${aws_subnet.public-subnet-1.id}"
  depends_on    = ["aws_internet_gateway.main-gw"]
}

resource "aws_nat_gateway" "nat-gw-2" {
  allocation_id = "${aws_eip.nat-eip-2.id}"
  subnet_id     = "${aws_subnet.public-subnet-2.id}"
  depends_on    = ["aws_internet_gateway.main-gw"]
}

### VPC setup for NAT
resource "aws_route_table" "main-private-1" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw-1.id}"
  }

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-pri1"
  }
}

resource "aws_route_table" "main-private-2" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw-2.id}"
  }

  tags {
    Name = "${var.VPC_NAME}-${var.ENV}-pri2"
  }
}

### route associations private
resource "aws_route_table_association" "main-private-1" {
  subnet_id      = "${aws_subnet.private-subnet-1.id}"
  route_table_id = "${aws_route_table.main-private-1.id}"
}

resource "aws_route_table_association" "main-private-2" {
  subnet_id      = "${aws_subnet.private-subnet-2.id}"
  route_table_id = "${aws_route_table.main-private-2.id}"
}
