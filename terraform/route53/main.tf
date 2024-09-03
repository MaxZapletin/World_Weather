resource "aws_route53_record" "weathly_org" {
  zone_id = var.hosted_zone_id  
  name    = var.record_name     
  type    = "A"

  alias {
    name                   = var.nlb_dns_name  
    zone_id                = var.nlb_zone_id   
    evaluate_target_health = false
  }
}
