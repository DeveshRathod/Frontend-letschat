output "alb_dns_name" {
  value = aws_lb.frontend.dns_name
  description = "frontend lb dns"
}

output "alb_dns_zone_id" {
  value = aws_lb.frontend.zone_id
  description = "frotend lb zone id"
}