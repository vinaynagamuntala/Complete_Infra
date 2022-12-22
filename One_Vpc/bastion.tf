#sg
resource "aws_security_group" "bastion_sg" {
  name        = "bastion"
  description = "Allow user"
  vpc_id      = aws_vpc.One_vpc.id

  ingress {
    description = "admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  ingress {
    description = "end_user"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "end_user"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bastion_sg"
  }
}

#instance
resource "aws_instance" "bastion" {
  ami                    = "ami-0cca134ec43cf708f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_sn[0].id
  key_name               = aws_key_pair.key.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion"
  }
}