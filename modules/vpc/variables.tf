variable "project" {
  type        = string
  description = "Enter your project Name"
  default     = "tf-demo"
}

variable "CostCenter" {
  type        = string
  description = "Provider your costcenter id"
  default     = "123"
}

variable "env" {
  type        = string
  description = "Select your environment like Dev, Test, Prod"
  default     = "Dev"
}

variable "vpc_cidr_block" {
  type = string 
  description = "Enter your cidr block for vpc"
  default = "192.168.0.0/16"
}