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

variable "reg_code" {
  description = "If informed, register the product using SUSEConnect"
  default     = ""
}

variable "reg_email" {
  description = "Email used for the registration"
  default     = ""
}

variable "reg_additional_modules" {
  description = "Map of the modules to be registered. Module name = Regcode, when needed."
  type        = "map"
  default     = {}
}

variable "additional_repos" {
  description = "extra repositories in the form {label = url}"
  default     = {}
}

variable "additional_packages" {
  description = "extra packages to install"
  default     = []
}

variable "hcount" {
  description = "Number of hosts like this one"
  default     = 1
}

variable "public_key_location" {
  description = "path of additional pub ssh key you want to use to access VMs"
  default     = "/dev/null"

  # HACK: "" cannot be used as a default because of https://github.com/hashicorp/hil/issues/50
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

variable "xmlfile" {
  description = "Path to xmlfile to define host. eg, (sbd disk) shareable"
  default     = "modules/host/shareable.xsl"
}

variable "salt_path" {
  description = "Path to the salt folder"
  default     = "./salt"
}

variable "additional_disk" {
  description = "disk block definition(s) to be added to this host"
  default     = []
}

variable "provisioner" {
  description = "Used provisioner option. Available options: salt. Let empty to not use any provisioner"
  default     = "salt"
}

variable "background" {
  description = "Run the provisioner execution in background if set to true finishing terraform execution"
  default     = false
}

variable "grains" {
  description = "custom grain string to be added to this host's configuration"
  default     = ""
}
