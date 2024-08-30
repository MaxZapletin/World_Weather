provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source = "./ecs"
  public_subnet_ids = module.vpc.public_subnet_ids
  ecs_security_group_id = module.vpc.ecs_security_group_id
}

module "vpc" {
  source = "./vpc"
}

module "iam" {
  source = "./iam"
}

# module "eks" {
#   source = "./eks"
# }