#-------------------------------------------------------#
#							#
#		Output variables			#
#							#
#-------------------------------------------------------#


output "ec2_name" {
  description = "Instance names"
  value = [aws_instance.ec2.*.tags_all.Name]
  #value = [aws_instance.ec2.*.instance_name]
}

output "ec2_ip" {
  description = "Instance public IP addresses"
  value = [aws_instance.ec2.*.public_ip]
}

output "jenkins_public_ip" {
  description = "Instance public IP addresses"
  value = [aws_instance.jenkins.public_ip]
}

output "registry_public_ip" {
  description = "Registry public IP addresses"
  value = [aws_instance.registry.public_ip]
}

output "ansible_public_ip" {
  description = "Ansible public IP addresses"
  value = [aws_instance.ansible.public_ip]
}
