resource "aws_instance" "sample_ec2" {
  ami             = "ami-0eb260c4d5475b901"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sample_sg.name]
  key_name        = "rs-euw-3"


  provisioner "file" {
    source      = "${path.module}/sample.sh"
    destination = "/home/ubuntu/sample.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/rs-euw-3.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo mkdir -p /home/ubuntu/test",
      "sudo apt install nginx -y",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/rs-euw-3.pem")
      host        = self.public_ip
    }
  }


  tags = {
    Name = "Sample-ec2"
    CostCenter = "123"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags
    ]
  }


}

resource "aws_security_group" "sample_sg" {
  name        = "sample-sg"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = "vpc-07d84c7c8e0d5782e"

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "terraform_data" "example1" {
  provisioner "local-exec" {
    command = "echo ${aws_instance.sample_ec2.private_ip} >> private_ips.txt"
  }
}

