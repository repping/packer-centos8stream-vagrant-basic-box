# Description
Packer setup to create VirtualBox-based Centos 8 Stream images for Vagrant.

# Pre-requirements
- VirtualBox, Packer and Vagrant are installed.

# Overview
![overview_diagram](README.images/overview_diagram.drawio.svg)


# HOWTO: Build the box

# Roadmap / ideas / improvements:
- variables section
  - with booleans to toggle for easy config
- secrets cleanup
- README
  - HOWTO: build + run
  - introduction
  - draw.io
- packer
  - config via root with ssh and pw, install python for ansible, create ansible user with key and sudo!, disable ssh for root!
- vagrant 
  - user ssh key
  - user without password in vagrantfile
  - user nopasswd
- multiple builds
  - minimal 
  - full
  - gui build
- basic configuration with ansible playbook
- Publish box(es) to artifact repo


