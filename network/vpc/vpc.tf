resource "aws_vpc" "fabio-leticia-vpc" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name = "fabio-leticia-vpc"
  }
  
}

resource "aws_internet_gateway" "fabio-leticia-igw" {
  vpc_id = aws_vpc.fabio-leticia-vpc.id
  tags = {
    Name = "fabio-leticia-igw"
  }
}

output "vpc_id" {
  value = aws_vpc.fabio-leticia-vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.fabio-leticia-igw.id
  
}



