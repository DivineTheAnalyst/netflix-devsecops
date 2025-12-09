data "http" "my_ip" {
  url = "https://ifconfig.me/ip"
}

resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ssh_from_publicip.id]

  tags = {
    Name = "dev"
  }
  
}

resource "aws_security_group" "ssh_from_publicip" {
  name        = "ssh_from_publicip"
  description = "Allow SSH from my public IP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(trimspace(data.http.my_ip.response_body))}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}