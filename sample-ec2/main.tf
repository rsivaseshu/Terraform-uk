terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "rssr-uk-tf-backend-1"
    key     = "terraform/uk/sample-ec2"
    region  = "eu-west-2"
    profile = "some"
  }
}

provider "aws" {
  region  = "eu-west-2"
  profile = "some"

}
