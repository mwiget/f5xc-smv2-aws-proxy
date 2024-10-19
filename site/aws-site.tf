module "aws-node" {
  count                     = length(var.aws_availability_zones)
  source                    = "./aws"
  f5xc_cluster_name         = format("%s%s",var.f5xc_vsite_name, element(var.aws_availability_zones, count.index))
  f5xc_virtual_site         = var.f5xc_vsite_name

  ssh_public_key            = var.ssh_public_key
  f5xc_tunnel_type          = var.f5xc_tunnel_type
  http_proxy                = var.http_proxy

  aws_region                = var.aws_region
  aws_availability_zone     = element(var.aws_availability_zones, count.index)
  aws_instance_type         = var.aws_instance_type
  aws_ami_name              = var.aws_ami_name
  aws_vpc_id                = aws_vpc.vpc.id
  aws_owner_tag             = var.aws_owner_tag

  aws_slo_subnet            = var.aws_slo_subnets[count.index]
  aws_sli_subnet            = var.aws_sli_subnets[count.index]
  aws_squid_ip              = var.aws_squid_ip[count.index]
  aws_internet_gateway_id   = aws_internet_gateway.gateway.id

  aws_sg_allow_slo_id       = resource.aws_security_group.allow_slo_traffic.id 
  aws_sg_allow_sli_id       = resource.aws_security_group.allow_sli_traffic.id 

}
