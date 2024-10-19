module "site1" {
  source                    = "./site"
  f5xc_vsite_name           = format("%s-aws-proxy-1", var.project_prefix)
  aws_instance_type         = "t3.xlarge"
  aws_region                = "us-west-1"
  aws_ami_name              = var.aws_ami_name
  ssh_public_key            = var.ssh_public_key

  providers       = {
    aws           = aws.us-west-1
  }

  aws_owner_tag             = var.aws_owner_tag
  aws_vpc_cidr              = "10.1.0.0/16"
  aws_availability_zones    = [ "a" ]
  aws_slo_subnets           = [ "10.1.1.0/24" ]
  aws_sli_subnets           = [ "10.1.11.0/24" ]
  aws_squid_ip              = [ "10.1.1.100" ]

  http_proxy                = "10.1.1.100:3128"

  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
}
