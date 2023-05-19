variable "sg_ids" {
type          = string
}

variable "subnet_ids" {
  type        = list
}

variable "vpc_id" {
   type       = string
}
variable "node-instance-type" {
  default     = "m4.large"
  type        = string
  description = "Worker Node EC2 instance"
}
variable "desired-capacity" {
  default     = 2
  type        = string
  description = "Autoscaling Desired node capacity"
}

variable "max-size" {
  default     = 5
  type        = string
  description = "Autoscaling maximum node capacity"
}

variable "min-size" {
  default     = 1
  type        = string
  description = "Autoscaling Minimum node capacity"
}

variable "root-block-size" {
  default     = "20"
  type        = string
  description = "Size of the root EBS block device"
}

variable "capacity_type" {
  default     = "ON_DEMAND"
  type        = string
  description = "on demand instance "
}

variable "ec2-key-public-key" {
  default     = ""
  type        = string
  description = "AWS EC2 public key data"
}
