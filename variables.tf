###############################################
variable "aws_token" {
  type            = string
}
variable "aws_role" {
  type            = string
}
variable "aws_arn" {
  type            = string
}
variable "aws_region" {
  type            = string
  default         = "eu-central-1"  # Change this to your desired region
}
###############################################
variable "bucket_name" {
  type            = string
  default         = "my-mpf-bucket"  # Change this to your desired bucket name
}
variable "bucket_acl" {
  type            = string
  default         = "private"  # Change this if you need a different ACL
}

variable "bucket_tags" {
  type            = map(string)
  default         = {
    Name          = "My MPF Bucket"
    Environment   = "Dev"
  }
}
variable "os-name" {
  default         = "ami-09ba48996007c8b50"
}

variable "vpc-cidr" {
  default         = "10.10.0.0/16"
}

variable "subnet1-cidr" {
  default         = "10.10.1.0/24"

}
variable "subnet2-cidr" {
  default         = "10.10.2.0/24"

}
variable "subnet_az" {
  default         =  "eu-central-1"
}
variable "subnet-2_az" {
  default         =  "eu-central-1"
}
data "aws_outposts_outpost" "shared" {
  name            = "SEA19.07"
}
variable "key-name" {
  default         = ""
}

variable "instance-type" {
  default         = "t2.small"
}
