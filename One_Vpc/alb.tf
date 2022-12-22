resource "aws_security_group" "alb_sg" {
  name        = "alb"
  description = "Allow user"
  vpc_id      = aws_vpc.One_vpc.id

  ingress {
    description = "apache"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "tomcat_jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "node_exporter"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "kibana"
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "elastic_search"
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "sonar"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "nexus"
    from_port   = 8081
    to_port     = 8081
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
    Name = "alb_sg"
  }
}

resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_sn[0].id, aws_subnet.public_sn[1].id, aws_subnet.public_sn[2].id]
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "alb_tg_1" {
  name     = "lb-tg-1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.alb_tg_1.arn
  target_id        = aws_instance.apache.id
  port             = 80
}

resource "aws_lb_target_group" "alb_tg_2" {
  name     = "lb-tg-2"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test2" {
  target_group_arn = aws_lb_target_group.alb_tg_2.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}

resource "aws_lb_target_group" "alb_tg_3" {
  name     = "lb-tg-3"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test3" {
  target_group_arn = aws_lb_target_group.alb_tg_3.arn
  target_id        = aws_instance.jenkins.id
  port             = 8080
}

resource "aws_lb_target_group" "alb_tg_4" {
  name     = "lb-tg-4"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test4" {
  target_group_arn = aws_lb_target_group.alb_tg_4.arn
  target_id        = aws_instance.Grafana.id
  port             = 3000
}

resource "aws_lb_target_group" "alb_tg_5" {
  name     = "lb-tg-5"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test5" {
  target_group_arn = aws_lb_target_group.alb_tg_5.arn
  target_id        = aws_instance.Grafana.id
  port             = 9090
}

resource "aws_lb_target_group" "alb_tg_6" {
  name     = "lb-tg-6"
  port     = 5601
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test6" {
  target_group_arn = aws_lb_target_group.alb_tg_6.arn
  target_id        = aws_instance.efk.id
  port             = 5601
}

resource "aws_lb_target_group" "alb_tg_7" {
  name     = "lb-tg-7"
  port     = 9200
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test7" {
  target_group_arn = aws_lb_target_group.alb_tg_7.arn
  target_id        = aws_instance.efk.id
  port             = 9200
}

resource "aws_lb_target_group" "alb_tg_8" {
  name     = "lb-tg-8"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test8" {
  target_group_arn = aws_lb_target_group.alb_tg_8.arn
  target_id        = aws_instance.sonar.id
  port             = 9000
}

resource "aws_lb_target_group" "alb_tg_9" {
  name     = "lb-tg-9"
  port     = 8081
  protocol = "HTTP"
  vpc_id   = aws_vpc.One_vpc.id
}

resource "aws_lb_target_group_attachment" "test9" {
  target_group_arn = aws_lb_target_group.alb_tg_9.arn
  target_id        = aws_instance.nexus.id
  port             = 8081
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_1.arn
  }
}

resource "aws_lb_listener_rule" "apache" {
  listener_arn = aws_lb_listener.alb_listener.arn
  # priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_1.arn
  }

  condition {
    host_header {
      values = ["apache.com"]
    }
  }
}

resource "aws_lb_listener_rule" "tomcat" {
  listener_arn = aws_lb_listener.alb_listener.arn
  # priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_2.arn
  }

  condition {
    host_header {
      values = ["tomcat.com"]
    }
  }
}

resource "aws_lb_listener_rule" "jenkins" {
  listener_arn = aws_lb_listener.alb_listener.arn
  # priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_3.arn
  }

  condition {
    host_header {
      values = ["jenkins.com"]
    }
  }
}

resource "aws_lb_listener_rule" "Grafana" {
  listener_arn = aws_lb_listener.alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_4.arn
  }

  condition {
    host_header {
      values = ["grafana.com"]
    }
  }
}

resource "aws_lb_listener_rule" "Prometheus" {
  listener_arn = aws_lb_listener.alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_5.arn
  }

  condition {
    host_header {
      values = ["prometheus.com"]
    }
  }
}

resource "aws_lb_listener_rule" "kibana" {
  listener_arn = aws_lb_listener.alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_6.arn
  }

  condition {
    host_header {
      values = ["kibana.com"]
    }
  }
}

resource "aws_lb_listener_rule" "elasticsearch" {
  listener_arn = aws_lb_listener.alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_7.arn
  }

  condition {
    host_header {
      values = ["elasticsearch.com"]
    }
  }
}

resource "aws_lb_listener_rule" "sonar" {
  listener_arn = aws_lb_listener.alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_8.arn
  }

  condition {
    host_header {
      values = ["sonarqube.com"]
    }
  }
}

resource "aws_lb_listener_rule" "nexus" {
  listener_arn = aws_lb_listener.alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_9.arn
  }

  condition {
    host_header {
      values = ["nexus.com"]
    }
  }
}