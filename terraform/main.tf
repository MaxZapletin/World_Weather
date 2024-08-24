provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source = "./ecs"
  ecr_repository_url = module.ecr.weather_repository_url
}

module "iam" {
  source = "./iam"
}

# module "eks" {
#   source = "./eks"
# }