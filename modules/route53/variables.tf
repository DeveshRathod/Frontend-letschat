variable "domain_name" {
  description = "Domain name for frontend"
  type = string
}

variable "record_name" {
  description = "Record name for frontend"
  type = string
}

variable "record_type" {
  description = "Record type for lb"
  type = string
}

variable "lb_dns_name" {
  description = "DNS name"
  type = string
}

variable "lb_zone_id" {
  description = "DNS name"
  type = string
}

variable "lb_evaluate_target_health" {
  description = "Evaluate target health"
  type = bool
}