#!/bin/bash

# Test for debugging
touch /home/vagrant/test_bootstrap_ansible.sh

# Bootstrap ansible for provisioning playbook
sudo yum install -y epel-release
sudo yum install -y ansible