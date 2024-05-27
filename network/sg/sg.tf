variable "vpc_id" {
  description = "VPC ID"
  type = string
  
}

resource "aws_security_group" "fabio-leticia-sg-front" {
  name        = "fabio-leticia-sg-front"
  description = "Security group for fabio-leticia frontend"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "fabio-leticia-sg-back" {
  name        = "fabio-leticia-sg-back"
  description = "Security group for fabio-leticia backend"
  vpc_id      = var.vpc_id
  depends_on = [ aws_security_group.fabio-leticia-sg-front ]

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.fabio-leticia-sg-front.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "fabio-leticia-sg-rds" {
  name        = "fabio-leticia-sg-rds"
  description = "Security group for fabio-leticia RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    security_groups = [aws_security_group.fabio-leticia-sg-back.id]
  }
}

resource "aws_security_group" "fabio-leticia-sg-alb" {
  name        = "fabio-leticia-sg-alb"
  description = "Security group for fabio-leticia ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "asg-sg" {
    name        = "asg-sg"
    description = "Security group for fabio-leticia ASG"
    vpc_id      = var.vpc_id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.fabio-leticia-sg-alb.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "rds-sg-id" {
  value = aws_security_group.fabio-leticia-sg-rds.id
}

output "front-sg-id" {
  value = aws_security_group.fabio-leticia-sg-front.id
}

output "back-sg-id" {
  value = aws_security_group.fabio-leticia-sg-back.id
}

output "alb-sg-id" {
  value = aws_security_group.fabio-leticia-sg-alb.id
}

output "asg-sg-id" {
  value = aws_security_group.asg-sg.id
  
}


