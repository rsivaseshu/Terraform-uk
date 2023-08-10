# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "web" {
  ami                                  = "ami-0eb260c4d5475b901"
  availability_zone                    = "eu-west-2b"
  iam_instance_profile                 = "ec2-jenkins-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.medium"
  key_name                             = "rs-euw-3"
  private_ip                           = "172.31.42.171"
  security_groups                      = ["jenkins-server"]
  subnet_id                            = "subnet-0b01698396f9cf440"
  tags = {
    Name = "jenkins"
  }
  vpc_security_group_ids      = ["sg-0fc5738a411a6d572"]

}
