resource "aws_vpc" "tf_demo" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name       = "${var.project}-vpc"
    CostCenter = var.CostCenter
    Env        = var.env
  }
}

################--public-subnets--####################

resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.tf_demo.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8 ,0)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name       = "${var.project}-pub-sub-1"
    CostCenter = var.CostCenter
    Env        = var.env
  }
}

resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.tf_demo.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8 ,1)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name       = "${var.project}-pub-sub-2"
    CostCenter = var.CostCenter
    Env        = var.env
  }
}

resource "aws_internet_gateway" "tf_demo_igw" {
  vpc_id = aws_vpc.tf_demo.id

  tags = {
    Name       = "${var.project}-igw"
    CostCenter = var.CostCenter
    Env        = var.env
  }
}

resource "aws_route_table" "tf_demo_pub_rt" {
  vpc_id = aws_vpc.tf_demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_demo_igw.id
  }

  tags = {
    Name       = "${var.project}-pub-rt"
    CostCenter = var.CostCenter
    Env        = var.env
  }
}

resource "aws_route_table_association" "tf_demo_pub_sub1_ass" {
  route_table_id = aws_route_table.tf_demo_pub_rt.id
  subnet_id      = aws_subnet.pub_sub_1.id
}

resource "aws_route_table_association" "tf_demo_pub_sub2_ass" {
  route_table_id = aws_route_table.tf_demo_pub_rt.id
  subnet_id      = aws_subnet.pub_sub_2.id
}

################--private-subnets--####################
resource "aws_subnet" "pri_sub_1" {
  vpc_id     = aws_vpc.tf_demo.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8 ,2)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name       = "${var.project}-pri-sub-1"
    CostCenter = var.CostCenter
    Env        = var.env
  }
}

resource "aws_subnet" "pri_sub_2" {
  vpc_id     = aws_vpc.tf_demo.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8 ,3)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name       = "${var.project}-pri-sub-2"
    CostCenter = var.CostCenter
    Env        = var.env
  }
}

resource "aws_route_table" "tf_demo_pri_rt" {
  vpc_id = aws_vpc.tf_demo.id

  tags = {
    Name       = "${var.project}-pri-rt"
    CostCenter = var.CostCenter
    Env        = var.env
  }
}

resource "aws_route_table_association" "tf_demo_pri_sub1_ass" {
  route_table_id = aws_route_table.tf_demo_pub_rt.id
  subnet_id      = aws_subnet.pri_sub_1.id
}

resource "aws_route_table_association" "tf_demo_pri_sub2_ass" {
  route_table_id = aws_route_table.tf_demo_pub_rt.id
  subnet_id      = aws_subnet.pri_sub_2.id
}
