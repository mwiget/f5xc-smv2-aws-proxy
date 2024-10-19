provider "restapi" {
  uri = var.f5xc_api_url
  create_returns_object = true
  headers = {
    Authorization = format("APIToken %s", var.f5xc_api_token)
    Content-Type  = "application/json"
  }
}

provider "aws" {
  region      = "us-west-1"
  alias       = "us-west-1"
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
}
