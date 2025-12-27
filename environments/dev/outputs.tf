output "nameservers" {
  value       = module.route53_module.nameservers
  description = "Nameservers for godaddy"
}