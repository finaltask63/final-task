#---------------------------------------------------------------#
#								#
#	Here defined network ACLs				#
#	One ACL for each network set:				#
#		- public segment, production environment	#
#		- public segment, developers environment	#
#		- private segment, production environment	#
#		- private segment, developers environment	#
#	ACL bindings to the networks are set with directive	#
#	'subnet_ids' inside each ACL.				#
#								#
#	Each public ACL allows:					#
#		- inbound HTTP from anywhere			#
#		- inbound HTTPS from anywhere			#
#		- inbound SSH from anywhere			#
#		- inbound ping from anywhere			#
#		- inbound TCP replies				#
#		- inbound UDP replies				#
#	Each public ACL blocks:					#
#		- inbound TCP from DEV (or PROD) networks	#
#		- inbound UDP from DEV (or PROD) networks	#
#								#
#	Each private ACL allows:				#
#		- inbound TCP from public network		#
#		- inbound UDP from public network		#
#		- inbound ping from anywhere			#
#	Each private ACL blocks:				#
#		- inbound TCP from DEV (or PROD) networks	#
#		- inbound UDP from DEV (or PROD) networks	#
#								#
#---------------------------------------------------------------#


# ---------- Public segment, production networks ---------- #

resource "aws_network_acl" "public_prod" {
  vpc_id = aws_vpc.main.id

  # Allow Inbound TCP ephemeral ports
  ingress {
    rule_no    = 10
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  # Allow Inbound UDP ephemeral ports (e.g. DNS replies)
  ingress {
    rule_no    = 20
    protocol   = "udp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  # Allow Inbound ping
  ingress {
    rule_no    = 30
    protocol   = "icmp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1
    to_port    = 65535
  }

  # Deny traffic from DEV public
  ingress {
    rule_no    = 40
    protocol   = "-1"
    action     = "deny"
    cidr_block = "10.1.64.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Deny traffic from DEV private
# Commented out to enable traffic via NAT gw
#  ingress {
#    rule_no    = 50
#    protocol   = "-1"
#    action     = "deny"
#    cidr_block = "10.1.192.0/18"
#    from_port  = 0
#    to_port    = 0
#  }

  # Allow Inbound HTTP
  ingress {
    rule_no    = 60
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Allow Inbound HTTPS
  ingress {
    rule_no    = 70
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Allow Inbound SSH
  ingress {
    rule_no    = 80
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  # Allow outbound traffic
  egress {
    rule_no    = 10
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-acl-public-prod"
    }
  )

}


# ---------- Public segment, developers networks ---------- #

resource "aws_network_acl" "public_dev" {
  vpc_id = aws_vpc.main.id

  # Allow Inbound TCP ephemeral ports
  ingress {
    rule_no    = 10
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  # Allow Inbound UDP ephemeral ports (e.g. DNS replies)
  ingress {
    rule_no    = 20
    protocol   = "udp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  # Allow Inbound ping
  ingress {
    rule_no    = 30
    protocol   = "icmp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1
    to_port    = 65535
  }

  # Allow traffic from 10.1.1.0/24 for Jenkins, Ansible etc.
  ingress {
    rule_no    = 40
    protocol   = "-1"
    action     = "allow"
    cidr_block = "10.1.1.0/24"
    from_port  = 0
    to_port    = 0
  }

  # Deny traffic from PROD public
  ingress {
    rule_no    = 50
    protocol   = "-1"
    action     = "deny"
    cidr_block = "10.1.0.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Deny traffic from PROD private
  ingress {
    rule_no    = 60
    protocol   = "-1"
    action     = "deny"
    cidr_block = "10.1.128.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Allow Inbound HTTP
  ingress {
    rule_no    = 70
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Allow Inbound HTTPS
  ingress {
    rule_no    = 80
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Allow Inbound SSH
  ingress {
    rule_no    = 90
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  # Allow outbound traffic
  egress {
    rule_no    = 10
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = [aws_subnet.subnet65.id, aws_subnet.subnet66.id, aws_subnet.subnet67.id]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-acl-public-dev"
    }
  )

}


# ---------- Private segment, production networks ---------- #

resource "aws_network_acl" "private_prod" {
  vpc_id = aws_vpc.main.id

  # Deny traffic from DEV public
  ingress {
    rule_no    = 10
    protocol   = "-1"
    action     = "deny"
    cidr_block = "10.1.64.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Deny traffic from DEV private
  ingress {
    rule_no    = 20
    protocol   = "-1"
    action     = "deny"
    cidr_block = "10.1.192.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Allow Inbound traffic from public prod
  ingress {
    rule_no    = 30
    protocol   = "-1"
    action     = "allow"
    cidr_block = "10.1.0.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Allow Inbound ping
  ingress {
    rule_no    = 40
    protocol   = "icmp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1
    to_port    = 65535
  }

  # Allow Inbound TCP ephemeral ports
  ingress {
    rule_no    = 50
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  # Allow Inbound UDP ephemeral ports (e.g. DNS replies)
  ingress {
    rule_no    = 60
    protocol   = "udp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  # Allow outbound traffic to the world
  egress {
    rule_no    = 10
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = [aws_subnet.subnet129.id, aws_subnet.subnet130.id, aws_subnet.subnet131.id]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-acl-private-prod"
    }
  )

}


# ---------- Private segment, developers networks ---------- #

resource "aws_network_acl" "private_dev" {
  vpc_id = aws_vpc.main.id

  # Allow traffic from 10.1.1.0/24 for Jenkins, Ansible etc.
  ingress {
    rule_no    = 10
    protocol   = "-1"
    action     = "allow"
    cidr_block = "10.1.1.0/24"
    from_port  = 0
    to_port    = 0
  }

  # Deny traffic from PROD public
  ingress {
    rule_no    = 20
    protocol   = "-1"
    action     = "deny"
    cidr_block = "10.1.0.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Deny traffic from PROD private
  ingress {
    rule_no    = 30
    protocol   = "-1"
    action     = "deny"
    cidr_block = "10.1.128.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Allow Inbound traffic from DEV public
  ingress {
    rule_no    = 40
    protocol   = "-1"
    action     = "allow"
    cidr_block = "10.1.64.0/18"
    from_port  = 0
    to_port    = 0
  }

  # Allow Inbound ping
  ingress {
    rule_no    = 50
    protocol   = "icmp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1
    to_port    = 65535
  }

  # Allow Inbound TCP ephemeral ports
  ingress {
    rule_no    = 60
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  # Allow Inbound UDP ephemeral ports (e.g. DNS replies)
  ingress {
    rule_no    = 70
    protocol   = "udp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  # Allow outbound traffic to the world
  egress {
    rule_no    = 10
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = [aws_subnet.subnet193.id, aws_subnet.subnet194.id, aws_subnet.subnet195.id]

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-acl-private-dev"
    }
  )

}
