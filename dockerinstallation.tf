provider "aws" {
   region = "us-east-2"
   access_key = "AKIAYKAEDH6NXKPSTIPI"
   secret_key = "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" 
}


resource "aws_instance" "web" {
  ami           = "ami-020db2c14939a8efb"
  instance_type = "t2.micro"
  key_name      = "munna"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  tags = {
    Name = "docker"
  }
  
}

resource "null_resource" "copy_execute" {
  
    connection {
    type = "ssh"
    host = aws_instance.web.public_ip
    user = "ubuntu"
    private_key = file("munna.pem")

    }


 
  provisioner "file" {
    source      = "docker.sh"
    destination = "/tmp/docker.sh"
  }
  
   provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/docker.sh",
      "sh /tmp/docker.sh",
    ]
  }
  
  }

resource "aws_security_group" "web" {
  name        = "web"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
}