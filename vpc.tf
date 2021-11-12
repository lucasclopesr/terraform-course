# Resources:
#   first arg: type of resource, second arg: logical name
resource "aws_vpc" "my_app" {
  cidr_block = var.vpc_cidr

  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
		environment = var.environment
    location = var.vpc_location
  }
}

output "vpc_cid" {
  value = aws_vpc.my_app.id
}
