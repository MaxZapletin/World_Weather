resource "aws_ecs_cluster" "main" {
  name = "weather-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
    repository_url           = module.ecr.weather_repository_url
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

