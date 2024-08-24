resource "aws_ecs_cluster" "main" {
  name = "weather-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Environment = "production"
    Project     = "WeatherApp"
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "app_template" {
  family                   = "weather-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "weather-app"
      image = "${aws_ecr_repository.weather.name}:latest"
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 80
        }
      ]
    }
  ])

  tags = {
    Environment = "production"
    Project     = "MyApp"
  }
}

# Outputs
output "ecs_cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "Name of the ECS cluster"
}

output "ecs_cluster_arn" {
  value       = aws_ecs_cluster.main.arn
  description = "ARN of the ECS cluster"
}

output "ecs_execution_role_arn" {
  value       = aws_iam_role.ecs_execution_role.arn
  description = "ARN of the ECS task execution role"
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.app_template.arn
  description = "ARN of the task definition template"
}