variable "vpc_cidr" {
  description = "VPC CIDR value"
  type        = string
}

variable "public_subnet" {
  description = "Public Subnet CIDR"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}