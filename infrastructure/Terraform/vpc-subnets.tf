#---------------------------------------------------------------#
#								#
#		My subnets are defined here			#
#								#
#	I have 3 availability zones - A, B and C		#
#	In each zone I'll set up:				#
#		- one prod public network,			#
#		- one dev public network,			#
#		- one prod private network and			#
#		- one dev private network.			#
#								#
#	Public networks will be: 10.1.0.0/17			#
#		public prod: 10.1.0.0/18			#
#		public dev: 10.1.64.0/18			#
#	Private networks will be: 10.1.128.0/17			#
#		private prod: 10.1.128.0/18			#
#		private dev: 10.1.192.0/18			#
#								#
#	With one /24 subnet for each network, I'll have:	#
#		10.1.0.0 - zero network, skip it		#
#		10.1.1.0 - public prod zone A			#
#		10.1.2.0 - public prod zone B			#
#		10.1.3.0 - public prod zone C			#
#		---------					#
#		10.1.64.0 - zero network, skip it		#
#		10.1.65.0 - public dev zone A			#
#		10.1.66.0 - public dev zone B			#
#		10.1.67.0 - public dev zone C			#
#		---------					#
#		10.1.128.0 - zero network, skip it		#
#		10.1.129.0 - private dev zone A			#
#		10.1.130.0 - private dev zone B			#
#		10.1.131.0 - private dev zone C			#
#		---------					#
#		10.1.192.0 - zero network, skip it		#
#		10.1.193.0 - private dev zone A			#
#		10.1.194.0 - private dev zone B			#
#		10.1.195.0 - private dev zone C			#
#								#
#---------------------------------------------------------------#



# ------------ Public segment ------------ #

# Prod networks

resource "aws_subnet" "subnet1" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "${local.region}a"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.public_prod ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-publicA-prod"
    }
  )

}


resource "aws_subnet" "subnet2" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "${local.region}b"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.public_prod ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-publicB-prod"
    }
  )

}


resource "aws_subnet" "subnet3" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.3.0/24"
  availability_zone = "${local.region}c"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.public_prod ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-publicC-prod"
    }
  )

}


# Dev networks

resource "aws_subnet" "subnet65" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.65.0/24"
  availability_zone = "${local.region}a"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.public_dev ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-publicA-dev"
    }
  )

}


resource "aws_subnet" "subnet66" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.66.0/24"
  availability_zone = "${local.region}b"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.public_dev ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-publicB-dev"
    }
  )

}


resource "aws_subnet" "subnet67" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.67.0/24"
  availability_zone = "${local.region}c"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.public_dev ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-publicC-dev"
    }
  )

}


# ------------ Private segment ------------ #

# Prod networks

resource "aws_subnet" "subnet129" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.129.0/24"
  availability_zone = "${local.region}a"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.private_prod ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-privateA-prod"
    }
  )

}


resource "aws_subnet" "subnet130" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.130.0/24"
  availability_zone = "${local.region}b"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.private_prod ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-privateB-prod"
    }
  )

}


resource "aws_subnet" "subnet131" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.131.0/24"
  availability_zone = "${local.region}c"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.private_prod ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-privateC-prod"
    }
  )

}


# Dev networks

resource "aws_subnet" "subnet193" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.193.0/24"
  availability_zone = "${local.region}a"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.private_dev ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-privateA-dev"
    }
  )

}


resource "aws_subnet" "subnet194" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.194.0/24"
  availability_zone = "${local.region}b"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.private_dev ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-privateB-dev"
    }
  )

}


resource "aws_subnet" "subnet195" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.195.0/24"
  availability_zone = "${local.region}c"
  map_public_ip_on_launch = true

  #depends_on = [ aws_network_acl.private_dev ]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-subnet-privateC-dev"
    }
  )

}
