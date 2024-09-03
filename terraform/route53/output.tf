output "route53_record_fqdn" {
  value       = aws_route53_record.weathly_org.fqdn
  description = "domain name  Route 53."
}
