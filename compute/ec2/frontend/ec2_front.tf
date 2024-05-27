variable "front-sg-id" {
  type = string
}

variable "subnet-front-id" {
  type = string
  
}

resource "aws_instance" "fabio-leticia-ec2-front" {
    ami = "ami-068dbbf2bb7023dea"
    instance_type = "t3.micro"
    subnet_id = var.subnet-front-id
    vpc_security_group_ids = [var.front-sg-id]

    user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd.x86_64
                systemctl start httpd.service
                systemctl enable httpd.service
                echo “Hello World from $(hostname -f)” > /var/www/html/index.html
                EOF
                
    tags = {
        Name = "fabio-leticia-ec2-front"
    }
  
}

resource "aws_eip" "fabio-leticia-eip" {
  instance = aws_instance.fabio-leticia-ec2-front.id
}

output "ec2-front-id" {
  value = aws_instance.fabio-leticia-ec2-front.id
}