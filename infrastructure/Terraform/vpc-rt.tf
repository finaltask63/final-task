#---------------------------------------------------------------#
#								#
#	Route tables for public and private network segments	#
#			With bindings				#
#								#
#---------------------------------------------------------------#


resource "aws_route_table" "rt_public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-rt-public"
    }
  )

}


resource "aws_route_table" "rt_private" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-rt-private"
    }
  )

}


resource "aws_route_table_association" "rta_publicA_prod" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt_public.id
}


resource "aws_route_table_association" "rta_publicB_prod" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt_public.id
}


resource "aws_route_table_association" "rta_publicC_prod" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "rta_publicA_dev" {
  subnet_id      = aws_subnet.subnet65.id
  route_table_id = aws_route_table.rt_public.id
}


resource "aws_route_table_association" "rta_publicB_dev" {
  subnet_id      = aws_subnet.subnet66.id
  route_table_id = aws_route_table.rt_public.id
}


resource "aws_route_table_association" "rta_publicC_dev" {
  subnet_id      = aws_subnet.subnet67.id
  route_table_id = aws_route_table.rt_public.id
}


resource "aws_route_table_association" "rta_privateA_prod" {
  subnet_id      = aws_subnet.subnet129.id
  route_table_id = aws_route_table.rt_private.id
}


resource "aws_route_table_association" "rta_privateB_prod" {
  subnet_id      = aws_subnet.subnet130.id
  route_table_id = aws_route_table.rt_private.id
}


resource "aws_route_table_association" "rta_privateC_prod" {
  subnet_id      = aws_subnet.subnet131.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rta_privateA_dev" {
  subnet_id      = aws_subnet.subnet193.id
  route_table_id = aws_route_table.rt_private.id
}


resource "aws_route_table_association" "rta_privateB_dev" {
  subnet_id      = aws_subnet.subnet194.id
  route_table_id = aws_route_table.rt_private.id
}


resource "aws_route_table_association" "rta_privateC_dev" {
  subnet_id      = aws_subnet.subnet195.id
  route_table_id = aws_route_table.rt_private.id
}
