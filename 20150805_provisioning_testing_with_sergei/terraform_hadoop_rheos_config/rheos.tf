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
    instance_type = "m3.xlarge"
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
    instance_type = "m3.xlarge"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "spark-0" {
    ami = "${var.ami_id}"
    tags {
       Name = "spark-0"
       KEEP = "${var.name_key}"
    }
    instance_type = "r3.2xlarge"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "spark-1" {
    ami = "${var.ami_id}"
    tags {
       Name = "spark-1"
       KEEP = "${var.name_key}"
    }
    instance_type = "r3.2xlarge"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "spark-2" {
    ami = "${var.ami_id}"
    tags {
       Name = "spark-2"
       KEEP = "${var.name_key}"
    }
    instance_type = "r3.2xlarge"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "kafka-0" {
    ami = "${var.ami_id}"
    tags {
        Name = "kafka-0"
        KEEP = "${var.name_key}"
    }
    instance_type = "m3.large"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}

resource "aws_instance" "kafka-1" {
    ami = "${var.ami_id}"
    tags {
        Name = "kafka-1"
        KEEP = "${var.name_key}"
    }
    instance_type = "m3.large"
    key_name = "${var.ssh_key}"
    root_block_device {
        volume_size = "${var.vol_size}"
    }
}
