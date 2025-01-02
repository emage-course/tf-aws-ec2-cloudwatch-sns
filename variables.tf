

########################################################################################################
# Create variables
########################################################################################################

variable "aws_region" {
  type        = string
  description = "AWS region to use for resources."
  default     = "us-east-2"
}

variable "aws_azs" {
  type        = list(string)
  description = "AWS Availability Zones"
  default     = ["us-east-2a", "us-east-2b"]
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR Block for Public Subnets in VPC"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "emagetech"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "LinuxWebServer"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
  default     = "webserver"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "emagetech.co"
}

variable "instance_key" {
  default = "workshop-key"
}

variable "email_address" {
  type        = list(string)
  description = "List of email addresses to receive email alert"
  default     = ["solomon.fwilliams@gmail.com"]
}

# variable "slack_webhook_url" {
#   type        = string
#   description = "The Slack webhook URL to send notifications"
#   default     = ["solomon.fwilliams@gmail.com"]
# }