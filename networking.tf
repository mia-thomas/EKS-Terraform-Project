#VPC 
resource "aws_vpc" "notion_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "notionTask1"
  }
}

#VPC Internet Gateway
resource "aws_internet_gateway" "notion_igw" {
  vpc_id = aws_vpc.notion_vpc.id

  tags = {
    Name = "igw_public"
  }
}

## EIP x3
resource "aws_eip" "eip_name" {
  for_each = var.public_subnets
  domain   = "vpc"

  tags = {
    Name = "eip ${each.key}"
  }
}

##CREATE NGW x3
resource "aws_nat_gateway" "ngwx3" {
  for_each      = var.public_subnets
  subnet_id     = aws_subnet.public_subnet[each.key].id
  allocation_id = aws_eip.eip_name[each.key].id

  tags = {
    Name = "ngw ${each.key}"
  }

  depends_on = [aws_subnet.public_subnet]
}

##CREATE RTBs
#PUBLIC RTB 
resource "aws_route_table" "notion_pub_rt" {
  vpc_id = aws_vpc.notion_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.notion_igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "pub_rtb_association" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.notion_pub_rt.id
}

# PRIVATE RTB 
resource "aws_route_table" "private_route_table" {
  for_each = var.private_subnets
  vpc_id   = aws_vpc.notion_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngwx3[each.key].id
  }

  tags = {
    Name = "${var.priv_route_name}-${each.key}"
  }
}

resource "aws_route_table_association" "priv_rtb_association" {
  for_each       = var.private_subnets
  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private_route_table[each.key].id
}
