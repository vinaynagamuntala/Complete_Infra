#security_group
resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat_sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.One_vpc.id

  ingress {
    description     = "admin"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description     = "admin"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tomcat_sg"
  }
}
#instance
resource "aws_instance" "tomcat" {
  ami                    = "ami-07ffb2f4d65357b42"
  instance_type          = "t2.large"
  subnet_id              = aws_subnet.private_sn[1].id
  key_name               = aws_key_pair.key.id
  vpc_security_group_ids = [aws_security_group.tomcat_sg.id]
  user_data              = file("tomcat-user-data.sh")

  tags = {
    Name = "tomcat"
  }
}