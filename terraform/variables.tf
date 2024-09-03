variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_profile" {
  default = "max"  
}

variable "hosted_zone_id" {
  description = "ID of the Route 53"
  type        = string
}

variable "record_name" {
  description = "DNS record to create in Route 53"
  type        = string
}
