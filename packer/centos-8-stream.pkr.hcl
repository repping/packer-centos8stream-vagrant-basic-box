# keeps ovf AND vagrant box
# check why vagrant home and tmp are not empty in box

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
    ssh_username = "root"
    ssh_password = "rootpassword" #SECRET!
    ssh_timeout = "10m"
    shutdown_command = "echo 'vagrant' | sudo -S shutdown now"
    disk_size = "20000"
    cpus = "2"
    memory = "4096"
    http_directory = "."
    boot_command = [
        "<up><tab><wait>",
        " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter>"
    ]
}

build {
    sources = [
        "sources.virtualbox-iso.centos-8-stream-builds"
    ]

    provisioner "shell" {
        scripts = ["./scripts/bootstrap_ansible.sh"]
        remote_folder = "/home/vagrant/"
        skip_clean = true
        execute_command = "echo 'vagrant' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'" #SECRET!
    }
     
   provisioner "ansible-local" {
        playbook_file = "./scripts/provisioning_playbook.yml"
        staging_directory = "/home/vagrant/"
        command = "/usr/bin/ansible-playbook"
    }

     provisioner "shell" {
        scripts = ["./scripts/cleanup.sh"]
        remote_folder = "/home/vagrant/"
        skip_clean = true
        execute_command = "echo 'vagrant' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'" #SECRET!
    }

    post-processor "vagrant" {
        compression_level = "6"
    }
}