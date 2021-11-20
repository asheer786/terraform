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
} resource "aws_security_group" "own-security" {
  name = "load"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}
