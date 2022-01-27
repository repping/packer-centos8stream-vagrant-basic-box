variable "isoPath"             {default = "../../images/CentOS-Stream-8-x86_64-latest-dvd1.iso"}
variable "isoChecksum"         {default = "sha256:00c26d315e7290745c07dacea927c87ebe6512406c14b9bb0ccb0224f01d59dd"}
variable "cpu"                 {default = "2"}
variable "memory"              {default = "4096"}
variable "sshUser"             {default = "root"}
variable "sshUserPassword"     {
    default = "rootpassword"
    sensitive = true
}
variable "vagrantBoxOutputFile" {default = "./builds/Centos8Stream.box"}