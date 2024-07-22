output "repository_url" {
  description = "URL of repository"
  value       = aws_ecr_repository.jenkins.repository_url
}

output "repository_arn" {
  description = "ARN of the repository"
  value       = aws_ecr_repository.jenkins.arn
}