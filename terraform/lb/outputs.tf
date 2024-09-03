output "weather_tg_arn" {
  value = aws_lb_target_group.weather_tg.arn
  description = "ARN of the Target Group for Weather App"
}

output "nlb_dns_name" {
  value = aws_lb.nlb.dns_name
  description = "The DNS name of the Network Load Balancer"
}

output "nlb_zone_id" {
  value = aws_lb.nlb.zone_id
  description = "The hosted zone ID of the Network Load Balancer"
}
