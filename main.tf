provider "aws" {
  region = "eu-west-1"
}

# create_vpc
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env}-vpc"
  }
}

# callinng_subnet_module
module "my-subnet" {
  source = "./modules/my-subnet"
  env = var.env
  vpc-id = aws_vpc.my-vpc.id
  vpc-default-route = aws_vpc.my-vpc.default_route_table_id
  subnet-cidr = var.subnet-cidr
}

# calling_ec2_module
module "my-ec2" {
  source = "./modules/my-ec2"
  env = var.env
  vpc-id = aws_vpc.my-vpc.id
  ingress-cidr = var.ingress-cidr
  subnet-id = module.my-subnet.my-subnet.id
  instance-type = var.instance-type
  ssh-pub = var.ssh-pub
}