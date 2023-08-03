output "vpc_id" {
  value = aws_vpc.tf_demo.id
}

output "pub_subnet1_id" {
  value = aws_subnet.pub_sub_1.id
}

output "pub_subnet2_id" {
  value = aws_subnet.pub_sub_2.id
}

output "pri_subnet1_id" {
  value = aws_subnet.pri_sub_1.id
}

output "pri_subnet2_id" {
  value = aws_subnet.pri_sub_2.id
}

output "vpc_cidr_block" {
  value = aws_vpc.tf_demo.cidr_block
}