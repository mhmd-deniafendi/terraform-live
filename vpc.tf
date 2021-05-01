# AWS Resource VPC
resource "aws_vpc" "vpc-bibit" {

  # IP CIDR blok yang nantinya akan digunakan  
  cidr_block       = "10.0.0.0/16"
  
  # Hanya untuk naming di AWS console   
  tags = {
    Name = "vpc-bibit"
  }
}