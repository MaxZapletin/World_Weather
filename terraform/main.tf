provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source                = "./ecs"
  public_subnet_ids     = module.vpc.public_subnet_ids
  ecs_security_group_id = module.vpc.ecs_security_group_id
  ecs_target_group_arn  = module.lb.weather_tg_arn 
}

module "vpc" {
  source = "./vpc"
}

module "iam" {
  source = "./iam"
}

module "lb" {
  source = "./lb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ecs_security_group_id = module.vpc.ecs_security_group_id  
}