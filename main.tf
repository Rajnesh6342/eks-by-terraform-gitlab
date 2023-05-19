##########################################
provider "aws" {
  region                          = var.aws_region
  assume_role_with_web_identity {
    role_arn                      = var.aws_role
    session_name                  = "gitlab"
    web_identity_token            = var.aws_token
  }
}
###########################################
resource "aws_s3_bucket" "mpf_bucket" {
  bucket                          = var.bucket_name
  acl                             = var.bucket_acl
  tags                            = var.bucket_tags
}

resource "aws_instance" "mpf-orchestrator-server" {
  ami                             = var.os-name
  key_name                        = var.key-name
  instance_type                   = var.instance-type
  associate_public_ip_address     = true
  subnet_id                       = aws_subnet.mpf-orchestrator_subnet-1.id
  vpc_security_group_ids          = [aws_security_group.mpf-orchestrator-vpc-sg.id]
}

// Create VPC
resource "aws_vpc" "mpf-orchestrator-vpc" {
  cidr_block                      = var.vpc-cidr
}

// Create Subnet
resource "aws_subnet" "mpf-orchestrator_subnet-1" {
  vpc_id                          = aws_vpc.mpf-orchestrator-vpc.id
  cidr_block                      = var.subnet1-cidr
  availability_zone               = var.subnet_az
  map_public_ip_on_launch         = "true"
  tags = {
    Name = "mpf-orchestrator_subnet-1"
  }
}
resource "aws_subnet" "mpf-orchestrator_subnet-2" {
  vpc_id                           = aws_vpc.mpf-orchestrator-vpc.id
  cidr_block                       = var.subnet2-cidr
  availability_zone                = var.subnet-2_az
  map_customer_owned_ip_on_launch  = "true"
  customer_owned_ipv4_pool         = aws_vpc.mpf-orchestrator-vpc.id
  outpost_arn                      = data.aws_outposts_outpost.shared.arn
  tags = {
    Name = "mpf-orchestrator_subnet-2"
  }
}
// Create Internet Gateway
resource "aws_internet_gateway" "mpf-orchestrator-igw" {
  vpc_id                           = aws_vpc.mpf-orchestrator-vpc.id
  tags = {
    Name = "mpf-orchestrator-igw"
  }
}
//Create Route table
resource "aws_route_table" "mpf-orchestrator-rt" {
  vpc_id                           = aws_vpc.mpf-orchestrator-vpc.id
  route {
    cidr_block                     = "0.0.0.0/0"
    gateway_id                     = aws_internet_gateway.mpf-orchestrator-igw.id
  }
  tags = {
    Name = "mpf-orchestrator-rt"
  }
}

// associate subnet with route table
resource "aws_route_table_association" "mpf-orchestrator-rt_association-1" {
  subnet_id                       = aws_subnet.mpf-orchestrator_subnet-1.id
  route_table_id                  = aws_route_table.mpf-orchestrator-rt.id
}

resource "aws_route_table_association" "mpf-orchestrator-rt_association-2" {
  subnet_id                       = aws_subnet.mpf-orchestrator_subnet-2.id
  route_table_id                  = aws_route_table.mpf-orchestrator-rt.id
}

// create a security group
resource "aws_security_group" "mpf-orchestrator-vpc-sg" {
  name                            = "mpf-orchestrator-vpc-sg"
  vpc_id                          = aws_vpc.mpf-orchestrator-vpc.id
  ingress {
    from_port                     = 22
    to_port                       = 22
    protocol                      = "tcp"
    cidr_blocks                   = ["0.0.0.0/0"]
    ipv6_cidr_blocks              = ["::/0"]
  }
  egress {
    from_port                     = 0
    to_port                       = 0
    protocol                      = "-1"
    cidr_blocks                   = ["0.0.0.0/0"]
    ipv6_cidr_blocks              = ["::/0"]
  }
  tags = {
    Name                          = "allow_tls"
  }
}
//call modules
module "mpf_sg_eks" {
  source                          = "./mpf_sg_eks"
  vpc_id                          = "aws_vpc.mpf-orchestrator-vpc.id"
}
module "mpf_eks" {
  source                          = "./mpf_eks"
  sg_ids                          = module.mpf_sg_eks.security_group_public
  vpc_id                          = aws_vpc.mpf-orchestrator-vpc.id
  subnet_ids                      = [aws_subnet.mpf-orchestrator_subnet-1.id,aws_subnet.mpf-orchestrator_subnet-2.id]

}

