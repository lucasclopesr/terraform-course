# We want to create 1 public subnet for each availability zones
# To do that, we will use a data source resource - aws_availability_zones

# Local variable containing the name of all AZs
locals {
  az_names = data.aws_availability_zones.azs.names
	pub_sub_ids = aws_subnet.public.*.id
}

resource "aws_subnet" "public" {
  # Create N resources, N = # of availability zones
  count = length(local.az_names)

  vpc_id     = aws_vpc.my_app.id

  # cidrsubnet is a function that iterates through subnet ranges, e.g.
  # 10.20.1.0/24
  # 10.20.2.0/24
  # 10.20.3.0/24
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)

  # Access AZ from data source using count as index
  availability_zone = local.az_names[count.index]

  # Enable public IP addresses on launch
  map_public_ip_on_launch = true

  tags = {
    # Define the name of the subnets according to their index
    Name = "PublicSubnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_app.id

  tags = {
    Name = "JavaHomeVPC"
  }
}

resource "aws_route_table" "prt" {
  vpc_id = aws_vpc.my_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "JavaHomePRT"
  }
}

resource "aws_route_table_association" "pub_sub_association" {
	count = length(local.az_names)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.prt.id
}
