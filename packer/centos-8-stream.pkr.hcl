packer {
    required_plugins {
        virtualbox = {
            version = " >= 0.0.1"
            source  = "github.com/hashicorp/virtualbox"
        }
    }
}

variable "rootpassword" {
    default = "rootpassword"
    sensitive = true
}

source "virtualbox-iso" "centos-8-stream-builds" {
    guest_os_type        = "RedHat_64"
    iso_url              = "../../images/CentOS-Stream-8-x86_64-latest-dvd1.iso"
    iso_checksum         = "sha256:00c26d315e7290745c07dacea927c87ebe6512406c14b9bb0ccb0224f01d59dd"
    ssh_username         = "root"
    ssh_password         = "${var.rootpassword}"
    ssh_timeout          = "15m"
    shutdown_command     = "shutdown now"
    disk_size            = "20000"
    cpus                 = "2"
    memory               = "4096"
    guest_additions_path = "/tmp"
    http_directory       = "."
    http_port_min        = "8555"
    http_port_max        = "8555"
    # http_bind_address    = "10.2.2.2"
    boot_command         = [
        "<up><tab><wait>",
        " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter>"
    ]
}

build {
    sources = [
        "sources.virtualbox-iso.centos-8-stream-builds"
    ]

#    provisioner "shell" {
#        scripts         = ["scripts/bootstrap_ansible.sh", "scripts/install_vbox_additions.sh"]
#        remote_folder   = "/tmp"
#        skip_clean      = true
#        execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
#    }
#     
#    provisioner "ansible-local" {
#        playbook_file     = "scripts/provisioning_playbook.yml"
#        staging_directory = "/tmp"
#        command           = "/usr/bin/ansible-playbook"
#    }
#
#     provisioner "shell" {
#        scripts         = ["scripts/cleanup.sh"]
#        remote_folder   = "/tmp"
#        skip_clean      = true
#        execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
#    }
#
#    post-processor "vagrant" {
#        keep_input_artifact = true
#        compression_level   = "0"
#    }
}