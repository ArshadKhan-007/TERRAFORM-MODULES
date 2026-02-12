resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "SG" {
    name        = "my-security-group"
    description = "My security group"
    vpc_id      = aws_default_vpc.default.id

  #inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }

  #outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    name = "my-security-group"
  }
}

resource "aws_instance" "web" {
  ami = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.SG.name]

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "WebServer"
  }
  
}