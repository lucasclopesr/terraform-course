# Let's use a local variable to define the range of the subnets
# The IP range should not conflict with the public subnets
locals {
  private_sub_begin = length(local.az_names)
}

resource "aws_subnet" "private" {
  # slice is a function that returns a slice of a list
  count = length(slice(local.az_names,0, 2))

  vpc_id     = aws_vpc.my_app.id

  # cidrsubnet is a function that iterates through subnet ranges, e.g.
  # 10.20.1.0/24
  # 10.20.2.0/24
  # 10.20.3.0/24
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + local.private_sub_begin)

  # Access AZ from data source using count as index
  availability_zone = local.az_names[count.index]

  tags = {
    # Define the name of the subnets according to their index
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

# NAT instance to control access to private subnet
resource "aws_instance" "nat" {
  ami                    = var.nat_amis[var.region]
  instance_type          = "t2.micro"
	subnet_id              = local.pub_sub_ids[0]
  source_dest_check      = false
  vpc_security_group_ids = [aws_security_group.nat_sg.id]

  tags = {
    Name = "JavaHomeNAT"
  }
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.my_app.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.nat.id
  }

  tags = {
    Name = "JavaHomePrivateRT"
  }
}

resource "aws_route_table_association" "private_rt_association" {
	count = length(slice(local.az_names,0, 2))
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.privatert.id
}

resource "aws_security_group" "nat_sg" {
  name        = "nat_sg"
  description = "Allow traffic for private subnets"
  vpc_id      = aws_vpc.my_app.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nat_sg"
  }
}
