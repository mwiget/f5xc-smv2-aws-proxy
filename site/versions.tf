terraform {
  required_providers {
    restapi = {
      source = "Mastercard/restapi"
      version = ">= 1.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.67.0"
    }    
  }
}
