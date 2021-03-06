terraform {
  required_version = "~> 0.12"
}

provider "libvirt" {
  uri = var.qemu_uri
}

resource "libvirt_volume" "sles4sap_12sp0" {
  name = "${var.name_prefix}_sap_12sp0"
  source = "http://download.suse.de/ibs/Devel:/SAP:/Terraform:/Images/images/SLES4SAP-12SP0-JeOS.x86_64.qcow2"
  count = var.use_shared_resources ? 0 : (contains(var.images, "sles4sap_12sp0") ? 1 : 0)
  pool = var.pool
}

resource "libvirt_volume" "sles4sap_12sp1" {
  name = "${var.name_prefix}_sap_12sp1"
  source = "http://download.suse.de/ibs/Devel:/SAP:/Terraform:/Images/images/SLES4SAP-12SP1-JeOS.x86_64.qcow2"
  count = var.use_shared_resources ? 0 : (contains(var.images, "sles4sap_12sp1") ? 1 : 0)
  pool = var.pool
}

resource "libvirt_volume" "sles4sap_12sp2" {
  name = "${var.name_prefix}_sap_12sp2"
  source = "http://download.suse.de/ibs/Devel:/SAP:/Terraform:/Images/images/SLES4SAP-12SP2-JeOS.x86_64.qcow2"
  count = var.use_shared_resources ? 0 : (contains(var.images, "sles4sap_12sp2") ? 1 : 0)
  pool = var.pool
}

resource "libvirt_volume" "sles4sap_12sp3" {
  name = "${var.name_prefix}_sap_12sp3"
  source = "http://download.suse.de/ibs/Devel:/SAP:/Terraform:/Images/images/SLES4SAP-12SP3-JeOS.x86_64.qcow2"
  count = var.use_shared_resources ? 0 : (contains(var.images, "sles4sap_12sp3") ? 1 : 0)
  pool = var.pool
}

resource "libvirt_volume" "sles4sap_12sp4" {
  name = "${var.name_prefix}_sap_12sp4"
  source = "http://download.suse.de/ibs/Devel:/SAP:/Terraform:/Images/images/SLES4SAP-12SP4-JeOS.x86_64.qcow2"
  count = var.use_shared_resources ? 0 : (contains(var.images, "sles4sap_12sp4") ? 1 : 0)
  pool = var.pool
}

resource "libvirt_volume" "sles4sap_15sp0" {
  name = "${var.name_prefix}_sap_15sp0"
  source = "http://download.suse.de/ibs/Devel:/SAP:/Terraform:/Images/images/SLES4SAP-15_SP0-JeOS.x86_64.qcow2"
  count = var.use_shared_resources ? 0 : (contains(var.images, "sles4sap_15sp0") ? 1 : 0)
  pool = var.pool
}

resource "libvirt_volume" "sles4sap_15sp1" {
  name = "${var.name_prefix}_sap_15sp1"
  source = "http://download.suse.de/ibs/Devel:/SAP:/Terraform:/Images/images/SLES4SAP-15_SP1-JeOS.x86_64.qcow2"
  count = var.use_shared_resources ? 0 : (contains(var.images, "sles4sap_15sp1") ? 1 : 0)
  pool = var.pool
}

output "configuration" {
  depends_on = [
    libvirt_volume.sles4sap_12sp0,
    libvirt_volume.sles4sap_12sp1,
    libvirt_volume.sles4sap_12sp2,
    libvirt_volume.sles4sap_12sp3,
    libvirt_volume.sles4sap_12sp4,
    libvirt_volume.sles4sap_15sp0,
    libvirt_volume.sles4sap_15sp1,
  ]

  value = {
    diskes = "${join(",", libvirt_volume.sles4sap_12sp0.*.name)},${join(",", libvirt_volume.sles4sap_12sp1.*.name)},${join(",", libvirt_volume.sles4sap_12sp2.*.name)},${join(",", libvirt_volume.sles4sap_12sp3.*.name)},${join(",", libvirt_volume.sles4sap_12sp4.*.name)},${join(",", libvirt_volume.sles4sap_15sp0.*.name)},${join(",", libvirt_volume.sles4sap_15sp1.*.name)}"

    // Provider-specific variables
    pool = var.pool
  }
}
