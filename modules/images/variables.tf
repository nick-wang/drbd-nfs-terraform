variable "qemu_uri" {
  description = "URI to connect with the qemu-service."
  default     = "qemu:///system"
}

variable "name_prefix" {
  description = "a prefix for all names of objects to avoid collisions."
  default     = "basetest"
}

variable "pool" {
  description = "libvirt storage pool name for VM disks. default: /var/lib/libvirt/images"
  default     = "default"
}

variable "use_shared_resources" {
  description = "use true to avoid deploying images, mirrors and other shared infrastructure resources"
  default     = false
}

# SUMA images
#variable "images" {
#  description = "list of images to be uploaded to the libvirt host, leave default for all"
#  default = ["centos7", "opensuse423", "opensuse150", "opensuse151", "sles15", "sles15sp1", "sles11sp4", "sles12", "sles12sp1", "sles12sp2", "sles12sp3", "sles12sp4", "ubuntu1804"]
#  type = "list"
#}

# SAP images
variable "images" {
  description = "list of images to be uploaded to the libvirt host, leave default for all"
  default = ["sles4sap_12sp0", "sles4sap_12sp1", "sles4sap_12sp2", "sles4sap_12sp3", "sles4sap_12sp4", "sles4sap_15sp0", "sles4sap_15sp1"]
  type = list
}
