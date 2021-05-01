# EIP (Elastic IP Address)
resource "aws_eip" "eip-bibit" {
  depends_on = [aws_internet_gateway.igw-vpc-bibit]  
}

# Create internet gateway (Jika dibutuhkan untuk terhubung ke internet)
resource "aws_internet_gateway" "igw-vpc-bibit" {
  vpc_id = aws_vpc.vpc-bibit.id

  tags = {
    Name = "igw-vpc-bibit"
  }
}

# Nat GW untuk terhubung ke private subnet
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.eip-bibit.id
  subnet_id     = aws_subnet.private-1.id

  tags = {
    Name = "Nat gw to private subnet"
  }
}
