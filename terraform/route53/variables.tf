variable "hosted_zone_id" {
  description = "The ID of the Route 53 hosted zone."
  type        = string
}

variable "record_name" {
  description = "The DNS record name to create."
  type        = string
  default     = "weathly.org"  
}

variable "nlb_dns_name" {
  description = "The DNS name of the Network Load Balancer."
  type        = string
}

variable "nlb_zone_id" {
  description = "The hosted zone ID of the Network Load Balancer."
  type        = string
}
