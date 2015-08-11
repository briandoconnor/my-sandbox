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

You also want execute the following in the shell to prevent annoying connection confirmations by Ansible:

    export ANSIBLE_HOST_KEY_CHECKING=False

## Launching Hadoop Cluster

To see what will be called, do the following in your `terraform_hadoop_config` directory:

    terraform plan

If that looks OK, go ahead and launch:

    launch_cluster.sh <path_to_AWS_ssh_pem_key>

This script will setup various things via Ansible including the Ambari Blueprint
for the Hadoop cluster.  This Blueprint functionality allows for a non-interactive
Hadoop cluster creation with a lot of flexibility in what packages are installed.

## Terminating Hadodop Cluster

You can terminate your cluster with:

    terraform destroy

## Custom Hadoop Clusters

Since Ambari allows for a lot of flexibility in creating clusters you can use
it to build Hadoop, HBase, Spark, and other related clusters.  You can also
use the stack presented here to spin up additional nodes that you configure
using Ansible playbooks.  In that way you can make a hybrid environment where
Ambari does the heavy lifting on packages/clusters it can manage and Ansible
configures other nodes for running services beyond the scope of Ambari.

To do this, you will need to basically copy the `terraform_hadoop_config` directory
to a new one (or fork the repo).  You can then customize the `bosun.tf` file
to spin up hosts that you want and develop new Ansible playbooks to configure them.

If you want to chagne the specifics of the Hadoop cluster the easiest way
is to use the Ambari GUI to build and customize a new cluster.

Take out the following two lines of `ambari.yml` file and then create a cluster:

    - name: load Blueprints
      command: 'curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://localhost:8080/api/v1/blueprints/HadoopBlueprint --data "@/tmp/blueprint.json"'
    - name: load Blueprints Cluster
      command: 'curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://localhost:8080/api/v1/clusters/HadoopCluster --data "@/tmp/cluster_creation.json"'

You'll be left with a Ambari server that's ready to graphically configure a new
Hadoop install.  Login with the default username and password (admin/admin) and then use the
wizard to create a new cluster:

    http://<ambari_host_name>:8080

The trick is to save the configuration as a blueprint that can be played back later, run this on the ambari host and copy the file created to `playbooks/blueprint.json`:

    curl -H "X-Requested-By: ambari" -X GET -u admin:admin http://<ambari_host_name>:8080/api/v1/clusters/brian_test?format=blueprint

You then need to customize the `playbooks/cluster_creation.json` file and
make any changes to `bosun.tf`.

At this poin you can throw away this Hadoop cluster, re-enable those lines in
the playbook, and rebuild your cluster.  If everything works you will be left
with a funtioning cluster that can be controlled via the Ambari dashboard.  And
if you extended the services with Ansible playbooks you can have other infrastructure
running as well.

## TODO

* need to decide on the ambari configuration, what services run where
* need to make a blueprint and edit the other config file, turn back on the auto-creation using new blueprint
* need to figure out the lvm or expanded root volume issue so the nodes can have sufficient storage
