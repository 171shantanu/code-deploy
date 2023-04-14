# Declaring locals
locals {
  name_suffix = "${var.project}-${var.environment}"
}

# variable for project
variable "project" {
  type        = string
  description = "Project Name"
  default     = "CodeDeploy"
}

# variable for environments
variable "environment" {
  type        = string
  description = "environment"
  default     = "Test"
}

# variable for the EC2 instance type
variable "ec2_instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}
