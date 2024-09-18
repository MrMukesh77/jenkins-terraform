resource "aws_vpc" "vpc-one" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "vpc-one"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc-one.id
}

resource "aws_subnet" "one-public-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.vpc-one.id
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true  
}

resource "aws_route_table" "one-public-route-table" {
    vpc_id = aws_vpc.vpc-one.id
}

resource "aws_route" "one-public-route" {
    route_table_id = aws_route_table.one-public-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "one-public-route-table-associate" {
    subnet_id = aws_subnet.one-public-subnet.id
    route_table_id = aws_route_table.one-public-route-table.id  
}