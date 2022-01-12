#!/bin/bash
# Required for installing VBoxGuestAdditions
sudo dnf install -y bzip2 tar

# Installation
sudo mkdir /home/vagrant/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions.iso /home/vagrant/VBoxGuestAdditions
sh /home/vagrant/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm /home/vagrant/VBoxGuestAdditions.iso
sudo umount /home/vagrant/VBoxGuestAdditions
sudo rmdir /home/vagrant/VBoxGuestAdditions