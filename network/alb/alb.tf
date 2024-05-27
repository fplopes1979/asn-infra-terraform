variable "vpc_id" {
  type = string
  
}

variable "alb-sg-id" {
  type = string
  
}

variable "ec2-front-id" {
  type = string
  
}

variable "subnet-front-id" {
  type = string
  
}

variable "subnet-public2-id" {
  type = string
  
}

resource "aws_alb" "fabio-leticia-alb" {
  name               = "fabio-leticia-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb-sg-id]
  subnets            = [var.subnet-front-id, var.subnet-public2-id]

  enable_deletion_protection = false

  tags = {
    Name = "fabio-leticia-alb"
  }

}

resource "aws_alb_target_group" "fabio-leticia-tg" {
  name     = "fabio-leticia-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = [ aws_alb.fabio-leticia-alb ]
}

resource "aws_alb_target_group_attachment" "fabio-leticia-tga" {
  target_group_arn = aws_alb_target_group.fabio-leticia-tg.arn
  target_id        = var.ec2-front-id
  port             = 80
}

output "alb_target_group_arn" {
  value = aws_alb_target_group.fabio-leticia-tg.arn
  
}