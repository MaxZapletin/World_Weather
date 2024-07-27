resource "aws_ecr_repository" "jenkins" {
  name                 = var.repository_name_jenkins
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

}

resource "aws_ecr_lifecycle_policy" "jenkins_policy" {
  repository = aws_ecr_repository.jenkins.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 5
      }
      action = {
        type = "expire"
      }
    }]
  })
}

resource "aws_ecr_repository" "weather" {
  name                 = var.repository_name_weather
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "Weather Repository"
    Environment = var.repository_name_weather
  }
}

resource "aws_ecr_lifecycle_policy" "weather_policy" {
  repository = aws_ecr_repository.weather.name

policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 5 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}