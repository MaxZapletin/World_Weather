provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "ec2" {
  source = "./ec2"
}

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source = "./ecs"
}

module "iam" {
  source = "./iam"
}

module "eks" {
  source = "./eks"
}