## About

An effort to spin up more complex infrastructure than Youxia (CloudBindle) currently
supports.

See https://medvedev.io/blog/ for the tutorial I'm using in the hadoop directory.  I basically took this tutorial and adapted it to work on AWS from DigitalOcean.  See original git here: https://github.com/dimamedvedev/bosun-install-example

## Configuring Hadoop

You will find a Terraform profile in `terraform_hadoop_config` to launch a small cluster on AWS.

First, copy the template for your settings:

    cp terraform.tfvars.template terraform.tfvars

Notice this file `terraform.tfvars` contains your keys, DO NOT CHECK THIS INTO GIT!

Next, you'll want to locate an acceptable AMI, I used `ami-8997afe0` as a base (in Virginia) but then created
my own AMI with the following two changes:

* `sudo yum update -y`: to update the packages and avoid an error with Terraform on SSL certs
* `sudo chkconfig iptables off`: turn off iptables for reboot

Keep in mind this image is pretty limited. If you were really running this in
production you would need to increase the storage by adding EBS volumes and
making sure the hadoop tools pointed their directories to locations off of the root partition.

At this point make a note of the new AMI in your account and change the file `terraform.tfvars`.  Also
change your AWS key and secret key in this file.

## Launching Hadoop

To see what will be called, do the following in your `terraform_hadoop_config` directory:

    terraform plan

If that looks OK, go ahead and launch:

    launch_cluster.sh <path_to_AWS_ssh_pem_key>
