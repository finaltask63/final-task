#-------------------------------------------------------#
#							#
#		My VPC definition here			#
#	VPC name variable defined in variables.tf	#
#							#
#-------------------------------------------------------#


resource "aws_vpc" "main" {

  cidr_block       = "10.1.0.0/16"

  tags = merge(
    var.common_tags,
    {
      Name = var.vpc_name
    }
  )

}
