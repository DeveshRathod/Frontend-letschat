resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "service_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.record_name
  type    = var.record_type

  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = var.lb_evaluate_target_health
  }
}
