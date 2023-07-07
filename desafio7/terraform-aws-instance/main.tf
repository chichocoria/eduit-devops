resource "aws_key_pair" "key" {
  key_name   = "hitesh_key"
  public_key = file("aws_ec2_eduit_desafio7.pub")
}

resource "aws_default_vpc" "default_vpc" {

}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow ssh and http inbound traffic"

  # using default VPC
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description = "TLS from VPC"

    # we should allow incoming and outoging
    # TCP packets
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    # allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"

    # we should allow incoming and outoging
    # TCP packets
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    # allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

resource "aws_instance" "example_server" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key.key_name
  security_groups = [aws_security_group.allow_ssh_http.name]
  tags = {
    Name = "eduit-example"
  }
}