#-----------------------------------------------------------------------#
#									#
#	Variables for our instances are defined here			#
#									#
#	The scheme is as follows:					#
#		- first, we'll create a 6 "working" instances		#
#		  for all zones in public				#
#		- second, we'll create 3 control instances:		#
#		  Ansible, Jenkins and Docker registry			#
#									#
#-----------------------------------------------------------------------#


variable "keypair" {
  type = string
  default = "devops13-keypair"
}


variable "ami_image" {

  description = "AMI image ID"
  type        = string
  default     = "ami-0ddf424f81ddb0720" # --- Ubuntu Linux ---
  #default     = "ami-0cea098ed2ac54925" # --- Amazoln Linux ---

}


variable "instance_count" {

  default = "12"

}


variable "instance_names" {
  description = "Working instance's names"
  type = list
  default = [
		"prod-masterA",
		"prod-masterB",
		"prod-masterC",
		"dev-masterA",
		"dev-masterB",
		"dev-masterC",
		"prod-nodeA",
		"prod-nodeB",
		"prod-nodeC",
		"dev-nodeA",
		"dev-nodeB",
		"dev-nodeC"
	]
}
