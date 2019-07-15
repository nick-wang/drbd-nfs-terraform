variable "base_configuration" {
  description = "use module.base.configuration, see the main.tf example file"
  type        = "map"
}

variable "qemu_uri" {
  description = "URI to connect with the qemu-service."
  default     = "qemu:///system"
}

variable "name" {
  description = "hostname, without the domain part"
  default     = "testnode"
}

variable "hcount" {
  description = "Number of hosts like this one"
  default     = 1
}

// Provider-specific variables
variable "memory" {
  description = "RAM memory in MiB"
  default     = 1024
}

variable "vcpu" {
  description = "Number of virtual CPUs"
  default     = 1
}

variable "cpu_model" {
  description = "Define what CPU model the guest is getting (host-model, host-passthrough or the default)."
  default = ""
}

variable "running" {
  description = "Whether this host should be turned on or off"
  default     = true
}

variable "xmlfile" {
  description = "Path to xmlfile to define host. eg, (sbd disk) shareable"
  default     = "modules/host/shareable.xsl"
}

variable "additional_disk" {
  description = "disk block definition(s) to be added to this host"
  default     = []
}
