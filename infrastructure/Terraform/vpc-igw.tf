#---------------------------------------#
#					#
#	Internet gateway for my VPC	#
#					#
#---------------------------------------#


resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-igw"
    }
  )

}
