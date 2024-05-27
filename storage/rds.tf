variable "rds-sg-id" {
  type = string
  
}

variable "subnet_id" {
  type = string
  
}

variable "subnet_id2" {
  type = string
  
}

resource "aws_db_subnet_group" "fabio-leticia-rds-subnet-group" {
  name       = "fabio-leticia-rds-subnet-group"
  subnet_ids = [var.subnet_id, var.subnet_id2]
}

resource "aws_db_instance" "fabio-leticia-rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  = false
  vpc_security_group_ids = [var.rds-sg-id]
  backup_retention_period = 7
  skip_final_snapshot = true
  tags = {
    Name = "fabio-leticia-rds"
  }
  db_subnet_group_name = aws_db_subnet_group.fabio-leticia-rds-subnet-group.name

}