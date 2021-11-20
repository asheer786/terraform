provider "aws" {
access_key = "AKIAYKAEDH6NXKPSTIPI"
secret_key = "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"
region = "us-east-2"
}

resource "aws_instance" "instance1" {
ami = "ami-020db2c14939a8efb"
instance_type = "t2.micro"
key_name = "munna"
tags = {
Name = "ec2-instance"
}
} resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-creation"
  }
}