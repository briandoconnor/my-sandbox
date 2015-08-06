variable "access_key" {}
variable "secret_key" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_instance" "ambari" {
    ami = "ami-8997afe0"
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
    ami = "ami-8997afe0"
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
    ami = "ami-8997afe0"
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
      ami = "ami-8997afe0"
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
      ami = "ami-8997afe0"
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
      ami = "ami-8997afe0"
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
