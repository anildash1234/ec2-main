resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public-subnet2.id
  vpc_security_group_ids = [aws_security_group.security-group.id]
  iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  root_block_device {
    volume_size = 30
  }
  user_data = templatefile("./install-tools.sh", {})

  tags = {
    Name = var.instance_name
  }
  depends_on = [ aws_vpc.vpc,aws_internet_gateway.igw,aws_subnet.public-subnet1,aws_subnet.public-subnet2,aws_route_table.rt,aws_security_group.security-group]
}