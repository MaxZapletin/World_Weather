output "weather_tg_arn" {
  value = aws_lb_target_group.weather_tg.arn
  description = "ARN of the Target Group for Weather App"
}
