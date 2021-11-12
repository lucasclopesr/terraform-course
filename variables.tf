variable "region" {
  description = "Resource region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Resource enviroment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Choose cidr for vpc"
  type        = string # string / map / list / boolean
  default     = "10.20.0.0/16"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_location" {
  description = "VPC location"
  type        = string
  default     = "Brazil"
}

variable "nat_amis" {
  type = map
  default = {
    us-east-1 = "ami-00a9d4a05375b2763"
    us-east-2 = "ami-00d1f8201864cc10c"
  }
}
