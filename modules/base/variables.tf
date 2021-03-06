variable "qemu_uri" {
  description = "URI to connect with the qemu-service."
  default     = "qemu:///system"
}

variable "prefix" {
  description = "a prefix for all names of objects to avoid collisions."
  default     = "basetest"
}

variable "pool" {
  description = "libvirt storage pool name for VM disks. default: /var/lib/libvirt/images"
  default     = "default"
}

variable "format" {
  description = "qemu image format"
  default     = "qcow2"
}

variable "image" {
  description = "Path to the template image."
  type        = string
}

variable "baseimg" {
  description = "Generated name of base image."
  default     = ""
}

variable "shared_img" {
  description = "use true to avoid deploying images, mirrors and other shared infrastructure resources"
  default     = false
}

variable "public_key_location" {
  description = "path of pub ssh key you want to use to access VMs"
  default     = "~/.ssh/id_rsa.pub"
}

variable "netname" {
  description = "Network name of libvirt. Not support empty for bridge. FIXME."
  default     = ""
}

variable "netmode" {
  description = "Network mode of libvirt. One of none, nat, route, bridge."
  default     = "nat"
}

variable "netdomain" {
  description = "Hostname's domain"
  default     = "me.local"
}

variable "iprange" {
  description = "Used host ip addresses range. Static IP will start as 192.168.XXX.Y(0), 192.168.XXX.Y(1)"
  type        = list
  // default     = ["192.168.10.10/24", "192.168.20.10/24"]
  default     = ["192.168.10.10/24"]
}

variable "dhcp" {
  description = "Whether use of network."
  type        = string
  default     = true
}

variable "timezone" {
  description = "Timezone setting for all VMs"
  default     = "Asia/Beijing"
}
