variable "access_key" {}
variable "secret_key" {}
variable "ami_id" {}
variable "name_key" {}
variable "vol_size" {}
variable "ssh_key" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_instance" "ambari" {
    ami = "${var.ami_id}"
    tags {
       Name = "ambari"
       KEEP = "${var.name_key}"
    }
    instance_type = "m1.medium"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "zoo-name" {
    ami = "${var.ami_id}"
    tags {
       Name = "zoo-name"
       KEEP = "${var.name_key}"
    }
    instance_type = "m1.medium"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "spark-store01" {
    ami = "${var.ami_id}"
    tags {
       Name = "spark-store01"
       KEEP = "${var.name_key}"
    }
    instance_type = "m1.large"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "spark-store02" {
      ami = "${var.ami_id}"
      tags {
         Name = "spark-store02"
         KEEP = "${var.name_key}"
      }
      instance_type = "m1.large"
      key_name = "${var.ssh_key}"
      root_block_device {
          volume_size = "${var.vol_size}"
      }
}

resource "aws_instance" "spark-store03" {
      ami = "${var.ami_id}"
      tags {
         Name = "spark-store03"
         KEEP = "${var.name_key}"
      }
      instance_type = "m1.large"
      key_name = "${var.ssh_key}"
      root_block_device {
          volume_size = "${var.vol_size}"
      }
}

resource "aws_instance" "kafka00" {
      ami = "${var.ami_id}"
      tags {
         Name = "kafka01"
         KEEP = "${var.name_key}"
      }
      instance_type = "m1.large"
      key_name = "${var.ssh_key}"
      root_block_device {
          volume_size = "${var.vol_size}"
      }
}

resource "aws_instance" "kafka01" {
      ami = "${var.ami_id}"
      tags {
         Name = "kafka02"
         KEEP = "${var.name_key}"
      }
      instance_type = "m1.large"
      key_name = "${var.ssh_key}"
      root_block_device {
          volume_size = "${var.vol_size}"
      }
}
