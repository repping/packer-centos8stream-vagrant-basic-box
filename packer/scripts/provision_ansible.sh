#!/bin/bash

# Bootstrap ansible for provisioning playbook
sudo dnf install -y epel-release 
sudo dnf install -y ansible
sudo pip3 install pexpect 