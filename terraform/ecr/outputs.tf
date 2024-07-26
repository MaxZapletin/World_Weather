output "jenkins_repository_url" {
  description = "URL Jenkins repository"
  value       = aws_ecr_repository.jenkins.repository_url
}

output "jenkins_repository_arn" {
  description = "ARN the Jenkins repository"
  value       = aws_ecr_repository.jenkins.arn
}

output "weather_repository_url" {
  description = "URL Weather repository"
  value       = aws_ecr_repository.weather.repository_url
}

output "weather_repository_arn" {
  description = "ARN the Weather repository"
  value       = aws_ecr_repository.weather.arn
}