terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
      configuration_aliases = [
        aws.management_account
      ]
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.0"
    }
  }
}
