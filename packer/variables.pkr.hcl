# Build variables:
variable "isoPath"                {default = "../../images/CentOS-Stream-8-x86_64-latest-dvd1.iso"}
variable "isoChecksum"            {default = "sha256:00c26d315e7290745c07dacea927c87ebe6512406c14b9bb0ccb0224f01d59dd"}
variable "cpu"                    {default = "2"}                            # CPU's available to VM during build.
variable "memory"                 {default = "4096"}                         # Memory available to VM during build. 

# Post build variables:
variable "rootPasswordAfterBuild" {
    default = "passwordforroot"                                              # This is the root password when the build has finished.
    type = string
}
variable "vagrantBoxOutputFile"   {default = "./builds/Centos8Stream.box"}   # This is where the image will be located when the build has finished.