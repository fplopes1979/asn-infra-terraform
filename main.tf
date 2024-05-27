provider "aws" {
  region = "us-west-2"
  
}

module "network" {
  source = "./network"
  
}

module "compute" {
  source = "./compute"
  
}

module "storage" {
  source = "./storage"
  rds-sg-id = module.sg.rds-sg-id
  subnet_id = module.subnet.subnet-private1-id
  subnet_id2 = module.subnet.subnet-private2-id
  }

module "sg" {
  source = "./network/sg"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "./network/vpc"
}

module "frontend" {
    source = "./compute/ec2/frontend"
    front-sg-id = module.sg.front-sg-id
    subnet-front-id = module.subnet.subnet-front-id

}

module "backend" {
    source = "./compute/ec2/backend"
    back-sg-id = module.sg.back-sg-id
    subnet-private1-id = module.subnet.subnet-private1-id
}

module "alb" {
    source = "./network/alb"
    vpc_id = module.vpc.vpc_id
    alb-sg-id = module.sg.alb-sg-id
    subnet-front-id = module.subnet.subnet-front-id
    ec2-front-id = module.frontend.ec2-front-id
    subnet-public2-id = module.subnet.subnet-public2-id
  }

module "subnet" {
  source = "./network/vpc/subnet"
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
}

module "asg" {
  source = "./compute/ec2/asg"
  front-sg-id = module.sg.front-sg-id
  subnet-front-id = module.subnet.subnet-front-id
  alb_target_group_arn = module.alb.alb_target_group_arn
  alb-sg-id = module.sg.alb-sg-id
  asg-sg-id = module.sg.asg-sg-id
}

module "iam" {
  source = "./iam"
}