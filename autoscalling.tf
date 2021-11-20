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