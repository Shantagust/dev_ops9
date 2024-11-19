provider "aws" {
  region = "eu-central-1"  # Укажите нужный регион
  version = "~> 4.0"
}


resource "aws_instance" "web" {
  ami           = "ami-0d17018cef51af497"
  instance_type = "t2.micro"

  # Привязка группы безопасности
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Теги для идентификации инстанса
  tags = {
    Name = "HTTP-Web-Instance"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Allow HTTP traffic"

  # Разрешить входящий HTTP-трафик
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешить весь исходящий трафик
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
