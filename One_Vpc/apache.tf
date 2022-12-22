#sg
resource "aws_security_group" "apache_sg" {
  name        = "apache"
  description = "Allow user"
  vpc_id      = aws_vpc.One_vpc.id

  ingress {
    description     = "admin"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description     = "end_user"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description     = "end_user"
    from_port       = 9100
    to_port         = 9100
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
    Name = "apache_sg"
  }
}

#instance
resource "aws_instance" "apache" {
  ami                    = "ami-0cca134ec43cf708f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_sn[0].id
  key_name               = aws_key_pair.key.id
  vpc_security_group_ids = [aws_security_group.apache_sg.id]
  user_data              = file("apache-user-data.sh")

  tags = {
    Name = "apache"
  }
}