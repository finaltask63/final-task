#-----------------------------------------------------------------------#
#									#
#	Here are defined security groups for my instances		#
#	There are just two of the kind:					#
#		- for public zone, common for all hosts			#
#		- for private zone, common for all hosts		#
#	Public allows HTTP, HTTPS, SSH and ping from the world.		#
#	Private allows the same from public.				#
#	Dev and prod environments isolation is already			#
#	in place with ACL (see vpc-acl.tf)				#
#									#
#	With this template, I can eventually add more			#
#		granular rules, if needed.				#
#									#
#-----------------------------------------------------------------------#


# ---------- Public group ----------

resource "aws_security_group" "public" {
  name        = "devops13-sg-public"
  description = "Security group for public zone"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP from world"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS from world"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from world"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Ping from world"
    from_port        = 0
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "For Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "For Docker Registry"
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-sg-public"
    }
  )

}


# ---------- Private group ----------

resource "aws_security_group" "private" {
  name        = "devops13-sg-private"
  description = "Security group for private zone"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP from public"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["10.1.0.0/17"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS from public"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["10.1.0.0/17"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from public"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.1.0.0/17"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Ping from public"
    from_port        = 0
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = ["10.1.0.0/17"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-sg-private"
    }
  )

}
