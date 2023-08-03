module "learning_vpc" {
  source         = "../modules/vpc/"
  project        = "learning"
  env            = "Dev"
  vpc_cidr_block = "10.1.0.0/16"
}

output "vpc_id" {
  value = module.learning_vpc.vpc_id
}