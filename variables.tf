variable "qemu_uri" {
  description = "URI to connect with the qemu-service."
  default     = "qemu:///system"
}

variable "image" {
  description = "Path to the image. FIXME."
  type        = "string"
}

variable "storage_pool" {
  description = "libvirt storage pool name for VM disks."
  default     = "default"
}

variable "hostname" {
  description = "hostname, without the domain part"
  default     = "testnode"
}

variable "hcount" {
  description = "Number of hosts like this one"
  default     = 1
}

variable "reg_code" {
  description = "If informed, register the product using SUSEConnect"
  default     = ""
}

variable "reg_email" {
  description = "Email used for the registration"
  default     = ""
}

# The module format must follow SUSEConnect convention:
# <module_name>/<product_version>/<architecture>
# Example: Suggested modules for SLES for SAP 15
# - sle-module-basesystem/15/x86_64
# - sle-module-desktop-applications/15/x86_64
# - sle-module-server-applications/15/x86_64
# - sle-ha/15/x86_64 (Need the same regcode as SLES for SAP)
# - sle-module-sap-applications/15/x86_64
variable "reg_additional_modules" {
  description = "Map of the modules to be registered. Module name = Regcode, when needed."
  type        = "map"
  default     = {}
}


variable "drbd_disk_count" {
  description = "Number of drbd disk"
  default     = 1
}

variable "drbd_disk_size" {
  description = "drbd partition disk size"
  default     = "1024000000"              # 1GB
}

variable "host_ips" {
  description = "IP addresses to set to the nodes"
  default     = []
}

variable "netmode" {
  description = "Network mode. One of none, nat, route, bridge"
  default     = "nat"
}

variable "iprange" {
  description = "IP range of the isolated network"
  type        = "list"
  default     = ["192.168.10.0/24"]
}

variable "shared_img" {
  description = "use true to avoid deploying images, mirrors and other shared infrastructure resources"
  default     = false
}

variable "name_prefix" {
  description = "Prefix of the deployment VM, network and disks"
  default     = "F"
}

variable "netname" {
  description = "Network name of libvirt. Not support empty for bridge. FIXME."
  default     = ""
}

variable "timezone" {
  description = "Timezone setting for all VMs"
  default     = "Asia/Beijing"
}
