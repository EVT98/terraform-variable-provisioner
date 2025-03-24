variable "region" {
  description = "region"
  type = string
  default = "us-east"
}

variable "instance-type" {
  description = "instance type"
  default = "t2.micro"
  type = string
}

variable "AZ" {
  description = "Availability zone"
  default = "us-east-1a"
}