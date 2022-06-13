resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.custom.id

  ingress {
    description      = "allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2 sg"
  }
}

output "aws_security_gr_id" {
  value = "${aws_security_group.allow_tls.id}"
}

resource "aws_instance" "public_ec2" {
  ami           = "ami-0022f774911c1d690"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
 subnet_id = "${aws_subnet.public.id}"
 key_name = "demo"
 associate_public_ip_address = true
 tags = {
   "Name" = "public instance"
 }
}

resource "aws_instance" "private_ec2" {
  ami           = "ami-0022f774911c1d690"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
 subnet_id = "${aws_subnet.private.id}"
 key_name = "demo"
 associate_public_ip_address = false
 tags = {
   "Name" = "private instance"
 }
}
resource "aws_eip" "lb" {
  instance = aws_instance.public_ec2.id
  vpc      = true
}