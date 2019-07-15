variable "qemu_uri" {
  description = "URI to connect with the qemu-service."
  default     = "qemu:///system"
}

variable "base_configuration" {
  description = "use ${module.base.configuration}, see the main.tf example file"
  type        = "map"
}

variable "name" {
  description = "sbd disk name"
  default     = "testnode"
}

variable "sbd_disk_size" {
  description = "sbd partition disk size"
  default     = "104857600"               # 100MB
}

variable "hcount" {
  description = "variable used to decide to create or not the sbd shared disk device"
  default     = 1
}

variable "xmlfile" {
  description = "Path to xmlfile to define sbd as a raw"
  default     = "modules/sbd/raw.xsl"
}
