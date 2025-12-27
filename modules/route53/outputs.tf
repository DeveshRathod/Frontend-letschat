output "nameservers" {
  value = aws_route53_zone.primary.name_servers
  description = "Nameservers for domain name"
}