variable "vpc_id" {
  description = "VPC ID"
  type = string
  
}

variable "igw_id" {
  description = "Internet Gateway ID"
  type = string
  
}

resource "aws_subnet" "fabio-leticia-subnet-public" {
  vpc_id = var.vpc_id
  cidr_block = "172.31.0.0/18"
  availability_zone = "us-west-2a"
  tags = {
    Name = "fabio-leticia-subnet-public"
  }
  
}

resource "aws_subnet" "fabio-leticia-subnet-private1" {
  vpc_id = var.vpc_id
  cidr_block = "172.31.64.0/18"
  availability_zone = "us-west-2b"
  tags = {
    Name = "fabio-leticia-subnet-private1"
  }
  
}

resource "aws_subnet" "fabio-leticia-subnet-private2" {
  vpc_id = var.vpc_id
  cidr_block = "172.31.128.0/18"
  availability_zone = "us-west-2c"
  tags = {
    Name = "fabio-leticia-subnet-private2"
  }
  
}

resource "aws_subnet" "fabio-leticia-subnet-public2" {
  vpc_id = var.vpc_id
  cidr_block = "172.31.192.0/18"
  availability_zone = "us-west-2d"
  tags = {
    Name = "fabio-leticia-subnet-public2"
  }
  
}

resource "aws_route_table" "fabio-leticia-rt-public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

resource "aws_route_table_association" "fabio-leticia-rt-public-association" {
  subnet_id      = aws_subnet.fabio-leticia-subnet-public.id
  route_table_id = aws_route_table.fabio-leticia-rt-public.id
}

resource "aws_route_table_association" "fabio-leticia-rt-public-association2" {
  subnet_id      = aws_subnet.fabio-leticia-subnet-public2.id
  route_table_id = aws_route_table.fabio-leticia-rt-public.id
}

output "subnet-front-id" {
  value = aws_subnet.fabio-leticia-subnet-public.id
}

output "subnet-private1-id" {
  value = aws_subnet.fabio-leticia-subnet-private1.id
  
}

output "subnet-public2-id" {
  value = aws_subnet.fabio-leticia-subnet-public2.id
  
}

output "subnet-private2-id" {
  value = aws_subnet.fabio-leticia-subnet-private2.id
  
}
