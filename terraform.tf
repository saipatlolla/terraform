provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "us-west-2"
}

resource "aws_instance" "testvm" {
  ami           = "ami-07b4f3c02c7f83d59"
  instance_type = "t2.micro"


}

variable "access_key" {
  type = string
  description = "The is access key"
}


variable "secret_key" {
  type = string
  description = "This is secret key"
}

