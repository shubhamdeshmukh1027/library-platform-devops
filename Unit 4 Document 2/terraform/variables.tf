variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "library-aws-key"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH. Replace with your own IP/32 for better security."
  type        = string
  default     = "0.0.0.0/0"
}
