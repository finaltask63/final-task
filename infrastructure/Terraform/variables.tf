#-------------------------------------------------------#
#							#
#	Global Input variables are defined here		#
#							#
#-------------------------------------------------------#


variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "devops13-vpc"
}

variable "common_tags" {

  description = "Additional resource tags"
  type = map(string)

  default = {
		Owner = "devops13"
		Purpose = "The final task"
	    }

}

variable "route53_id" {
  description = "Root zone ID (training.triangu.com)"
  type        = string
  default     = "Z1T7STVWPLPSW7"
}
