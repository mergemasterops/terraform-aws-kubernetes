variable "region" {
  description = "The region in which the resources will be deployed"
  default     = "ap-southeast-2"

}
variable "availablity_zone" {
  description = "The availablity zone in which the reosources will be created"
  default     = "ap-southeast-2a"

}
variable "AMI" {
  description = "The AMI to use for the EC2 instance"
  default     = "ami-06259b63260eddc13"

}
variable "instance_type" {
  description = "The type of the EC2 instance"
  default     = "t2.medium"

}
variable "akumar" {
  description = "The name of the keypair to use for the EC2 instance"
  default     = "akumar"

}
variable "VPC_ID" {
  description = "The VPC ID to use for the instance"
  default     = "vpc-c57fbda1"

}
variable "volume_size" {
  description = "The sis of the EBS volume to attach to the instance"
  default     = 20

}

variable "instance_name" {
  description = "Name of the EC2 instance"
  default     = "CP"

}

variable "aws_security_group" {
  description = "Security group for AWS resource"
  default     = "mergemasterops_IAC_SG"

}