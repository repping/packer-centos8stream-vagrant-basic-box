packer {
    required_plugins {
        virtualbox = {
            version = " >= 0.0.1"
            source  = "github.com/hashicorp/virtualbox"
        }
    }
}

source "virtualbox-iso" "Centos8Stream" {
    guest_os_type        = "RedHat_64"
    iso_url              = "${var.isoPath}"
    iso_checksum         = "${var.isoChecksum}"
    ssh_username         = "root"
    ssh_password         = "rootpassword"                                # Must match (crypted) pw in the kickstart-file!
    ssh_timeout          = "15m"
    shutdown_command     = "shutdown now"
    disk_size            = "20000"
    cpus                 = "${var.cpu}"
    memory               = "${var.memory}"
    guest_additions_path = "/tmp/VBoxGuestAdditions.iso"
    http_directory       = "."
    boot_command         = [
        "<up><tab><wait>",
        " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter>"
    ]
}

build {
    sources = [
        "sources.virtualbox-iso.Centos8Stream"
    ]

   provisioner "shell" {
       scripts         = ["scripts/provision_ansible.sh", "scripts/provision_vbox_additions.sh"]
       remote_folder   = "/tmp"
       skip_clean      = true
       execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
   }
    
   provisioner "ansible-local" {
       playbook_file     = "scripts/provision_playbook.yml"
       staging_directory = "/tmp"
       extra_arguments   = ["--extra-vars", "\"rootPassword=${var.rootPasswordAfterBuild}\""]
       command           = "/usr/bin/ansible-playbook"
   }

    provisioner "shell" {
       scripts         = ["scripts/provision_cleanup.sh"]
       remote_folder   = "/tmp"
       skip_clean      = true
       execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
   }

   post-processor "vagrant" {
       keep_input_artifact = true
       output              = "${var.vagrantBoxOutputFile}"
       compression_level   = "0"
   }
}