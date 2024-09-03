variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ID of the ECS security group"
  type        = string
}

variable "ecs_target_group_arn" {
  description = "ARN of the target group to attach to ECS service"
  type        = string
}