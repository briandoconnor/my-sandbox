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
    instance_type = "m4.xlarge"
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
    instance_type = "m4.xlarge"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "spark" {
    count = "3"
    ami = "${var.ami_id}"
    tags {
       Name = "${concat("spark-", count.index)}"
       KEEP = "${var.name_key}"
    }
    instance_type = "r3.2xlarge"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}


resource "aws_instance" "kafka" {
    count = 2
    ami = "${var.ami_id}"
    tags {
        Name = "${concat("kafka-", count.index)}"
        KEEP = "${var.name_key}"
    }
    instance_type = "m4.large"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}
