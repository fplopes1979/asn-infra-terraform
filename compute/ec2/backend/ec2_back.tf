variable "back-sg-id" {
    type = string
}

variable "subnet-private1-id" {
    type = string
  
}

resource "aws_instance" "fabio-leticia-ec2-back" {
    ami = "ami-0395649fbe870727e"
    instance_type = "t2.micro"
    subnet_id = var.subnet-private1-id
    vpc_security_group_ids = [var.back-sg-id]
    tags = {
        Name = "fabio-leticia-ec2-back"
        Periodo = "8"
    }
  
}