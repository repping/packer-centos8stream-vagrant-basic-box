#!/bin/bash
# Required for installing VBoxGuestAdditions
dnf install -y gcc make perl kernel-devel-$(uname -r) kernel-headers-$(uname -r) bzip2 dkms elfutils-libelf-devel
export KERN_DIR=/usr/src/kernels/$(uname -r)

# Installation
mkdir -p /tmp/VBoxGuestAdditions
mount -o loop,ro /tmp/VBoxGuestAdditions.iso /tmp/VBoxGuestAdditions
sh /tmp/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm /tmp/VBoxGuestAdditions.iso
umount /tmp/VBoxGuestAdditions
rmdir /tmp/VBoxGuestAdditions