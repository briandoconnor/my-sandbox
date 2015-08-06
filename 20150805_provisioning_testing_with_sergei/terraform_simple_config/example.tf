provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami = "ami-aa7ab6c2"
    tags {
       Name = "BrianTerraformTest"
       KEEP = "BRIAN"
    }
    instance_type = "t1.micro"
}
