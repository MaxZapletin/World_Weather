variable "ecr_repository_url" {
  description = "The URL ECR repository"
  type        = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

