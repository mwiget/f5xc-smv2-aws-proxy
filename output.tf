output "site1" {
  value = module.site1
  sensitive = true
}

output "ip_address" {
  value = flatten(concat(
    module.site1[*].node.aws[*].ip_address,
    module.site1[*].node.aws[*].squid_ip_address
  ))
}

