provider "aws" {
    access_key = ["access_key"]
    secret_key = ["secret_key"]
    region = "	us-west-2"

resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "testvpc"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id     = "${aws_vpc.test_vpc.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "testsubnet"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [0.0.0.0/0]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_instance" "testvm" {
  ami = "ami-005bdb005fb00e791"
  instance_type = "t2.micro"
  subnet_id = ["${aws_subnet.test_subnet.id}"]
  security_groups = ["${aws_security_group.allow_http.id}"]
}

resource "aws_network_interface" "test_nic" {
  subnet_id       = "${aws_subnet.test_subnet.id}"
  private_ips     = ["10.0.0.10"]
  security_groups = ["${aws_security_group.allow_http.id}"]

}

}





