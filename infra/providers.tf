provider "aws" {
    region = "us-east-1"
    access_key = "AKIA4TYTXHRGRX4YREGUA"
    secret_key = "E0XYg6JVVz9Rzak1Iu1IQsjd0bhsVTvfGkV6YGZvA"
}

resource "aws_vpc" "custom" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
      Name = "Public Subnet"
  }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.custom.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "false"
    tags = {
      Name = "Private Subnet"
  }
}
  
 /* resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "vpc igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.custom.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public route"
  }
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

*/

