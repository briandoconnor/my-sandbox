variable "access_key" {}
variable "secret_key" {}
variable "ami_id" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_instance" "ambari" {
    ami = "${var.ami_id}"
    tags {
       Name = "ambari"
       KEEP = "BRIAN"
    }
    instance_type = "m1.medium"
    key_name = "brian-oicr-3"
    root_block_device {
        volume_size = "30"
    }
}

resource "aws_instance" "bosun-store00" {
    ami = "${var.ami_id}"
    tags {
       Name = "bosun-store00"
       KEEP = "BRIAN"
    }
    instance_type = "m1.large"
    key_name = "brian-oicr-3"
    root_block_device {
        volume_size = "30"
    }
}

resource "aws_instance" "bosun-store01" {
    ami = "${var.ami_id}"
    tags {
       Name = "bosun-store01"
       KEEP = "BRIAN"
    }
    instance_type = "m1.large"
    key_name = "brian-oicr-3"
    root_block_device {
        volume_size = "30"
    }
}

resource "aws_instance" "bosun-store02" {
      ami = "${var.ami_id}"
      tags {
         Name = "bosun-store02"
         KEEP = "BRIAN"
      }
      instance_type = "m1.large"
      key_name = "brian-oicr-3"
      root_block_device {
          volume_size = "30"
      }
}

resource "aws_instance" "bosun-store03" {
      ami = "${var.ami_id}"
      tags {
         Name = "bosun-store03"
         KEEP = "BRIAN"
      }
      instance_type = "m1.large"
      key_name = "brian-oicr-3"
      root_block_device {
          volume_size = "30"
      }
}

resource "aws_instance" "bosun-server" {
      ami = "${var.ami_id}"
      tags {
         Name = "bosun-server"
         KEEP = "BRIAN"
      }
      instance_type = "m1.large"
      key_name = "brian-oicr-3"
      root_block_device {
          volume_size = "30"
      }
}
