provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "ecr" {
  source = "./ecr"
  tags = {
    Name = "ECR Module"
  }
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
  tags = {
    Name = "IAM Module"
  }
}

module "lb" {
  source = "./lb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ecs_security_group_id = module.vpc.ecs_security_group_id  
}

module "route53" {
  source = "./route53"

  hosted_zone_id = var.hosted_zone_id
  record_name    = var.record_name
  nlb_dns_name   = module.lb.nlb_dns_name  
  nlb_zone_id    = module.lb.nlb_zone_id   
}

