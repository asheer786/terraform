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
} 

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-creation"
  }   
}

resource "aws_elb" "example" {
  name = "elastic-Load-balancer"
    availability_zones = ["us-east-2a"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}

 resource "aws_security_group" "own-security" {
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

resource "aws_launch_template" "server" {
  name_prefix   = "asheer"
  image_id      = "ami-020db2c14939a8efb"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "ag" {
  availability_zones = ["us-east-2a"]
  desired_capacity   = 3
  max_size           = 4
  min_size           = 3

  launch_template {
    id      = aws_launch_template.server.id
    version = "$Latest"
  }
}

resource "aws_eip" "elasticip" {
    instance = aws_instance.instance1.id
    vpc = true
    tags = {
        Name = "Elasticipaddress"
    }
}
