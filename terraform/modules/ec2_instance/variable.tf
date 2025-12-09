variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string  
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EC2 instance will be launched"
  type        = string
}