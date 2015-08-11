#!/bin/bash

# build the cluster
terraform apply

# sleep for hosts to launch
sleep 60

# generate playbook
bash gen_ansible_inventory.sh

# setup hosts with Ansible
ansible-playbook --private-key=$1 -i inventory ./playbooks/common.yml
ansible-playbook --private-key=$1 -i inventory ./playbooks/ambari.yml
