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

