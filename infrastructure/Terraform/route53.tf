#---------------------------------------------------------------#
#								#
#	Route53 configuration here				#
#								#
#	We have to add DNS records for each EC2 instance	#
#								#
#---------------------------------------------------------------#


# One input point - DNS "load balancer" :-)
resource "aws_route53_record" "root" {

  depends_on = [aws_instance.ec2]

  zone_id = var.route53_id
  name = "devops13"
  type = "A"
  ttl = 300
  records = [
    aws_instance.ec2[0].public_ip,
    aws_instance.ec2[1].public_ip,
    aws_instance.ec2[2].public_ip,
  ]

}

# The same for DEV
resource "aws_route53_record" "root_dev" {

  depends_on = [aws_instance.ec2]

  zone_id = var.route53_id
  name = "devops13-dev"
  type = "A"
  ttl = 300
  records = [
    aws_instance.ec2[3].public_ip,
    aws_instance.ec2[4].public_ip,
    aws_instance.ec2[5].public_ip,
  ]

}

# Records for all working hosts - public IP
resource "aws_route53_record" "hosts" {

  depends_on = [aws_instance.ec2]

  count = var.instance_count

  zone_id = var.route53_id
  name = "${lower(element(var.instance_names,count.index))}.devops13.training.triangu.com"
  type = "A"
  ttl = 300
  records = [ aws_instance.ec2[count.index].public_ip ]

}

# Records for all working hosts - private IP
resource "aws_route53_record" "hosts-local" {

  depends_on = [aws_instance.ec2]

  count = var.instance_count

  zone_id = var.route53_id
  name = "${lower(element(var.instance_names,count.index))}-local.devops13.training.triangu.com"
  type = "A"
  ttl = 300
  records = [ aws_instance.ec2[count.index].private_ip ]

}

# Record for Jenkins - public IP
resource "aws_route53_record" "jenkins" {

  depends_on = [aws_instance.jenkins]

  zone_id = var.route53_id
  name = "jenkins.devops13.training.triangu.com"
  type = "A"
  ttl = 300
  records = [ aws_instance.jenkins.public_ip ]

}

# Record for Jenkins - private IP
resource "aws_route53_record" "jenkins_local" {

  depends_on = [aws_instance.jenkins]

  zone_id = var.route53_id
  name = "jenkins-local.devops13.training.triangu.com"
  type = "A"
  ttl = 300
  records = [ aws_instance.jenkins.private_ip ]

}

# Record for Ansible - public IP
resource "aws_route53_record" "ansible" {

  depends_on = [aws_instance.ansible]

  zone_id = var.route53_id
  name = "ansible.devops13.training.triangu.com"
  type = "A"
  ttl = 300
  records = [ aws_instance.ansible.public_ip ]

}

# Record for Ansible - private IP
resource "aws_route53_record" "ansible_local" {

  depends_on = [aws_instance.ansible]

  zone_id = var.route53_id
  name = "ansible-local.devops13.training.triangu.com"
  type = "A"
  ttl = 300
  records = [ aws_instance.ansible.private_ip ]

}

# Record for Docker registry - public IP
resource "aws_route53_record" "registry" {

  depends_on = [aws_instance.registry]

  zone_id = var.route53_id
  name = "registry.devops13.training.triangu.com"
  type = "A"
  ttl = 300
  records = [ aws_instance.registry.public_ip ]

}

# Record for registry - private IP
resource "aws_route53_record" "registry_local" {

  depends_on = [aws_instance.registry]

  zone_id = var.route53_id
  name = "registry-local.devops13.training.triangu.com"
  type = "A"
  ttl = 300
  records = [ aws_instance.registry.private_ip ]

}
