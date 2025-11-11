provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "iac-demo-public-bucket"
  acl    = "public-read"   # inseguro: acesso público total

  tags = {
    Name        = "iac-demo-public"
    Environment = "dev"
  }
}

resource "aws_security_group" "open_sg" {
  name        = "iac-demo-open-sg"
  description = "SG com portas abertas"
  vpc_id      = "vpc-123456"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # inseguro: acesso global
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
