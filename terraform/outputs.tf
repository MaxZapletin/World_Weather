output "jenkins_ecr_repository_url" {
  description = "URL of Jenkins ECR repository"
  value       = module.ecr.repository_url
}