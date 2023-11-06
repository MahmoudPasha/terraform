# create default gateway to attached it to vpc
resource "aws_internet_gateway" "my-igw" {
  vpc_id = var.vpc-id
  tags = {
    Name = "${var.env}-igw"
  }
}
# create default-route-table
resource "aws_default_route_table" "my-rtb" {
  default_route_table_id = var.vpc-default-route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "${var.env}-route"
  }
}
# create subnet
resource "aws_subnet" "my-subnet" {
  vpc_id = var.vpc-id
  cidr_block = var.subnet-cidr
  tags = {
    Name = "${var.env}-subnet"
  }
}
# we don't need to atached route table to subnet, as we edit in default vpc route table
# that attached to all subnets by default
