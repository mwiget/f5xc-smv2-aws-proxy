variable "ssh_public_key" {}
variable "f5xc_vsite_name" {}

variable "master_cpus" {
  type = number
  default = 4
}
variable "master_memory" {
  type = number
  default = 16384
}
variable "http_proxy" {
  type = string
  default = ""
}
variable "f5xc_api_url" {
  type = string
}
variable "f5xc_api_token" {
  type = string
}
variable "f5xc_tenant" {
  type = string
}
variable "secure_mesh_cpus" {
  type = number
  default = 4
}
variable "secure_mesh_memory" {
  type = number
  default = 16384
}
variable "outside_network" {
  type = string
  default = "vmbr0"
}
variable "outside_ip_address" {
  type = list(string)
  default = []
}
variable "outside_ip_gateway" {
  type = string
  default = ""
}
variable "outside_ip_dns" {
  type = string
  default = ""
}
variable "slo_interface" {
  type = string
  default = ""
}
variable "sli_interface" {
  type = string
  default = ""
}
variable "outside_network_vlan" {
  type = number
  default = -1
}
variable "inside_network" {
  type = string
  default = ""
}
variable "inside_network_vlan" {
  type = number
  default = -1
}
variable "inside_ipv4_prefix" {
  type = string
  default = "192.168.100.0/24"
}
variable "inside_dhcp_pool_start" {
  type = string
  default = "192.168.100.10"
}
variable "inside_dhcp_pool_end" {
  type = string
  default = "192.168.100.200"
}
variable "kubevirt" {
  type = bool
  default = false
}
variable "f5xc_registration_wait_time" {
    type    = number
    default = 80
}

variable "f5xc_registration_retry" {
    type    = number
    default = 20
}

variable "f5xc_tunnel_type" {
  type    = string
  default = "SITE_TO_SITE_TUNNEL_IPSEC_OR_SSL"
}

variable "operating_system_version" {
  type    = string
  default = ""
}

variable "outside_macaddr" {
  type    = string
  default = ""
}

variable "inside_vip" {
  type  = string
  default = ""
}

variable "master_vm_size" {
  type = string
  default = "50G"
}

variable "worker_vm_size" {
  type = string
  default = "50G"
}

variable "slo_global_vn" {
  type = string
  default = ""
}

# AWS

variable "aws_vpc_cidr" {
  type = string
  default = ""
}
variable "aws_owner_tag" {
  type = string
  default = ""
}
variable "aws_slo_subnets" {
  type = list(string)
  default = []
}
variable "aws_sli_subnets" {
  type = list(string)
  default = []
}
variable "aws_squid_ip" {
  type = list(string)
  default = []
}
variable "aws_region" {
  type = string
  default = ""
}
variable "aws_availability_zones" {
  type = list(string)
  default = []
}
variable "aws_instance_type" {
  type = string
  default = ""
}
variable "aws_ami_name" {
  type = string
  default = ""
}
variable "nutanix_image_url" {
  type = string
  default = ""
}
variable "type" {
  type = string
  default = ""
}
variable "f5xc_namespace" {
  type = string
  default = "default"
}
