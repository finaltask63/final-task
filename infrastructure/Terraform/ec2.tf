#-----------------------------------------------------------------------#
#									#
#	My EC2 instances here.						#
#									#
#	Variables are defined in variables-ec2.tf			#
#									#
#       The scheme is as follows:                                       #
#               - first, we'll create a 6 "working" instances,		#
#                 one per zone in public and private segments		#
#               - second, we'll create a 6 "testing" instances,		#
#                 one per zone in public and private segments and	#
#               - third, we'll create 1 control instance		#
#									#
#-----------------------------------------------------------------------#


resource "aws_instance" "ec2" {

  depends_on = [
		aws_subnet.subnet1,   aws_subnet.subnet2,   aws_subnet.subnet3,
		aws_subnet.subnet65,  aws_subnet.subnet66,  aws_subnet.subnet67,
		aws_subnet.subnet129, aws_subnet.subnet130, aws_subnet.subnet131,
		aws_subnet.subnet193, aws_subnet.subnet194, aws_subnet.subnet195,
		aws_security_group.public, aws_security_group.private
	       ]


  count = var.instance_count

  ami = var.ami_image
  key_name = var.keypair


  instance_type = element(
			    tolist( [
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro",
					"t2.micro"
				    ] ),
			    count.index
			 )

  subnet_id = element(
			tolist( [
					aws_subnet.subnet1.id,
					aws_subnet.subnet2.id,
					aws_subnet.subnet3.id,
					aws_subnet.subnet65.id,
					aws_subnet.subnet66.id,
					aws_subnet.subnet67.id,
					aws_subnet.subnet129.id,
					aws_subnet.subnet130.id,
					aws_subnet.subnet131.id,
					aws_subnet.subnet193.id,
					aws_subnet.subnet194.id,
					aws_subnet.subnet195.id
				] ),
			count.index
		     )

  vpc_security_group_ids = [
			element(
				tolist( [
					aws_security_group.public.id,
					aws_security_group.public.id,
					aws_security_group.public.id,
					aws_security_group.public.id,
					aws_security_group.public.id,
					aws_security_group.public.id,
					aws_security_group.private.id,
					aws_security_group.private.id,
					aws_security_group.private.id,
					aws_security_group.private.id,
					aws_security_group.private.id,
					aws_security_group.private.id
				] ),
				count.index
			)
		]

  user_data = <<EOF
#!/bin/bash
hostnamectl set-hostname ${lower(element(var.instance_names,count.index))}
EOF

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-${element(var.instance_names,count.index)}"
    },
  )

}

resource "aws_instance" "jenkins" {

  depends_on = [ aws_instance.ec2, aws_instance.registry ]

  ami = var.ami_image
  key_name = var.keypair


  instance_type = "t2.micro"

  subnet_id = aws_subnet.subnet1.id

  vpc_security_group_ids = [ aws_security_group.public.id ]

  user_data = <<EOF
#!/bin/bash
hostnamectl set-hostname jenkins
EOF

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-jenkins"
    },
  )

}

resource "aws_instance" "registry" {

  depends_on = [ aws_subnet.subnet1, aws_security_group.public ]

  ami = var.ami_image
  key_name = var.keypair


  instance_type = "t2.micro"

  subnet_id = aws_subnet.subnet1.id

  vpc_security_group_ids = [ aws_security_group.public.id ]

  user_data = <<EOF
#!/bin/bash
hostnamectl set-hostname registry
EOF

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-registry"
    },
  )

}

resource "aws_instance" "ansible" {

  depends_on = [ aws_instance.ec2, aws_instance.jenkins, aws_instance.registry ]

  ami = var.ami_image
  key_name = var.keypair

  instance_type = "t2.micro"

  subnet_id = aws_subnet.subnet1.id

  vpc_security_group_ids = [ aws_security_group.public.id ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("/opt/final-task/ansible/devops13-keypair.pem")}"
    host        = "${self.public_ip}"
  }

  provisioner "file" {
    source      = "/opt/final-task"
    destination = "/home/ubuntu/final-task"
  }

  provisioner "remote-exec" {
    inline = [
      "cp /home/ubuntu/final-task/ansible/ansible-startup.sh /home/ubuntu/final-task/ansible/registry-up.sh /home/ubuntu/final-task/ansible/masters-up.sh /home/ubuntu/final-task/ansible/nodes-up.sh /home/ubuntu/final-task/ansible/jenkins-up.sh .",
      "sudo chmod +x ansible-startup.sh registry-up.sh masters-up.sh nodes-up.sh jenkins-up.sh",
      "sudo ./ansible-startup.sh",
      "sudo ./registry-up.sh",
      "sudo ./masters-up.sh",
      "sudo ./nodes-up.sh",
      "sudo ./jenkins-up.sh"
    ]
  }

  user_data = <<EOF
#!/bin/bash
hostnamectl set-hostname ansible
EOF

  tags = merge(
    var.common_tags,
    {
      Name = "devops13-ansible"
    },
  )

}
