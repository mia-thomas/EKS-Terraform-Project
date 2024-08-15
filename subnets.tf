
resource "aws_subnet" "public_subnet" {
  for_each = var.public_subnets

  availability_zone = each.value["az"]
  cidr_block        = each.value["cidr"]
  vpc_id            = aws_vpc.notion_vpc.id

  tags = {
    Name = "${var.public_sub_name}-subnet-${each.key}"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each = var.private_subnets

  availability_zone = each.value["az"]
  cidr_block        = each.value["cidr"]
  vpc_id            = aws_vpc.notion_vpc.id


  tags = {
    Name = "${var.private_sub_name}-subnet-${each.key}"
  }
}
