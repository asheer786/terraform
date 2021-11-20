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
resource "aws_elb" "example" {
  name = "ElasticloadBalancer"
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