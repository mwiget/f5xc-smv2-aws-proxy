output "nodes" {
  value = {
#    master  = aws_instance.master_vm
    squid   = aws_instance.squid_vm
  }
}

output "ip_address" {
    value = {
    for node in range(length(aws_instance.master_vm)):
      aws_instance.master_vm[node].tags.Name => aws_eip.sm_pub_ips[node].public_ip
  }
}

output "squid_ip_address" {
    value = {
    for node in range(length(aws_instance.squid_vm)):
      aws_instance.squid_vm[node].tags.Name => aws_instance.squid_vm[node].public_ip
  }
}
