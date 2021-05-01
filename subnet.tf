# Public Subnet
resource "aws_subnet" "public-1" {
  cidr_block = "10.0.0.0/28"
  vpc_id = aws_vpc.vpc-bibit.id
  availability_zone = "ap-southeast-1"

  tags {
    Name = "public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private-1" {
  cidr_block = "10.0.1.0/28"
  vpc_id = aws_vpc.vpc-bibit.id
  availability_zone = "ap-southeast-1"

  tags {
    Name = "private-subnet"
  }
}

