#-----------------------------------------------#
#						#
#	Here is defined the NAT gateway		#
#		(with Elastic IP)		#
#	for private networks Internet access	#
#						#
#-----------------------------------------------#


resource "aws_eip" "eip" {

  vpc      = true

}


resource "aws_nat_gateway" "nat" {

  depends_on = [aws_internet_gateway.igw]

  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet1.id

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-nat"
    }
  )

}
