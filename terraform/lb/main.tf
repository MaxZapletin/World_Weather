resource "aws_lb" "nlb" {
  name               = "world-weather"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  tags = {
    Name = "world-weather"
  }
}

resource "aws_lb_target_group" "weather_tg" {
  name        = "weather-tg"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = {
    Name = "weather-tg"
  }
}

variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}
