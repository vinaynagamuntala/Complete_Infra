resource "aws_vpc" "One_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "One_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.One_vpc.id

  tags = {
    Name = "igw"
  }
  depends_on = [aws_vpc.One_vpc]
}

resource "aws_subnet" "public_sn" {
  count                   = length(data.aws_availability_zones.az.names)
  vpc_id                  = aws_vpc.One_vpc.id
  cidr_block              = element(var.pub_cidr, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.az.names, count.index)

  tags = {
    "Name" = "public_sn-${count.index + 1}"
  }
}

resource "aws_subnet" "private_sn" {
  count             = length(data.aws_availability_zones.az.names)
  vpc_id            = aws_vpc.One_vpc.id
  cidr_block        = element(var.private_cidr, count.index)
  availability_zone = element(data.aws_availability_zones.az.names, count.index)

  tags = {
    "Name" = "private_sn-${count.index + 1}"
  }
}

resource "aws_subnet" "data_sn" {
  count             = length(data.aws_availability_zones.az.names)
  vpc_id            = aws_vpc.One_vpc.id
  cidr_block        = element(var.data_cidr, count.index)
  availability_zone = element(data.aws_availability_zones.az.names, count.index)

  tags = {
    "Name" = "data_sn-${count.index + 1}"
  }
}

resource "aws_eip" "eip" {
  vpc = true

  tags = {
    "Name" = "eip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_sn[0].id

  tags = {
    Name = "ngw"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.eip]
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.One_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_route"
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.One_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "private_route"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public_sn[*].id)
  subnet_id      = element(aws_subnet.public_sn[*].id, count.index)
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private_sn[*].id)
  subnet_id      = element(aws_subnet.private_sn[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "data" {
  count          = length(aws_subnet.data_sn[*].id)
  subnet_id      = element(aws_subnet.data_sn[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}