variable "front-sg-id" {
    type = string
  
}

variable "subnet-front-id" {
    type = string
  
}

variable "alb_target_group_arn" {
    type = string
  
}

variable "alb-sg-id" {
    type = string
  
}

variable "asg-sg-id" {
    type = string
  
}


resource "aws_launch_template" "fabio_leticia_launch_template" {
    name = "fabio-leticia-launch-template"
    image_id = "ami-068dbbf2bb7023dea"
    instance_type = "t2.micro"
    user_data = base64encode(<<-EOF
#!/bin/bash
sudo yum update -y
systemctl start docker
sudo docker run -dp 80:3000 fplopes1979/getting-started
EOF
    )
    network_interfaces {
        associate_public_ip_address = true
        security_groups = [var.asg-sg-id]
    }
}

resource "aws_autoscaling_group" "fabio_leticia_asg" {
    name = "fabio-leticia-asg"
    desired_capacity = 1
    max_size = 2
    min_size = 1
    health_check_grace_period = 300
    health_check_type = "ELB"
    vpc_zone_identifier = [var.subnet-front-id]
    target_group_arns = [ var.alb_target_group_arn ]
    launch_template {
        id = aws_launch_template.fabio_leticia_launch_template.id
        version = "$Latest"
    }
    tag {
        key = "Name"
        value = "fabio-leticia-asg"
        propagate_at_launch = true
    }
}
