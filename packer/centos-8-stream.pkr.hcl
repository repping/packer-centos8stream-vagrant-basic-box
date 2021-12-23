packer {
    required_plugins {
        virtualbox = {
            version = ">= 0.0.1"
            source = "github.com/hashicorp/virtualbox"
        }
    }
}

source "virtualbox-iso" "centos-8-stream-builds" {
    guest_os_type = "RedHat_64"
    iso_url = "file://P:/images/CentOS-Stream-8-x86_64-latest-dvd1.iso"
    iso_checksum = "sha256:00c26d315e7290745c07dacea927c87ebe6512406c14b9bb0ccb0224f01d59dd"
    ssh_username = "vagrant"
    ssh_password = "vagrant" #SECRET!
    ssh_timeout = "15m"
    shutdown_command = "echo 'vagrant' | sudo -S shutdown now"
    disk_size = "20000"
    cpus = "2"
    memory = "8192"
    http_directory = "."
    boot_command = [
        "<tab><wait>",
        " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter>"
    ]
}

# Ergens moet nog een kickstart file geplaatst worden, nu faalt de installatie.

build {
    sources = ["sources.virtualbox-iso.centos-8-stream-builds"]
}