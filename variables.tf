variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable "ssl_certificate_id" {
  description = "ARN of the SSL certificate for ELB"
  type        = string
}

variable "domain_name" {
  description = "Domain name for Route53 hosted zone"
  type        = string
}
