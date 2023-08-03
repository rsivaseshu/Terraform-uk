resource "aws_instance" "tf_demo_ec2" {
  ami           = "ami-0eb260c4d5475b901"
  instance_type = "t2.micro"
  key_name      = "rs-euw-3"

  vpc_security_group_ids = [aws_security_group.tf_demo_sg.id]
  subnet_id              = module.learning_vpc.pub_subnet1_id

  #user_data = filebase64("${path.module}/nginx.sh")
  user_data = <<EOF
    #!/bin/bash
    sudo apt update -y
    sudo mkdir /home/ubuntu/project
    sudo apt install nginx -y
    sudo echo "Hi Welcome to the nginx" > /var/www/html/index.html
  EOF


  tags = {
    Name = "Learning-demo-ec2"
  }

}

resource "aws_security_group" "tf_demo_sg" {
  name        = "tf-demo-sg"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = module.learning_vpc.vpc_id

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
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