terraform {
  required_version = "~> 0.11.7"
}

provider "libvirt" {
  uri = "${var.qemu_uri}"
}

// https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/volume.html.markdown
resource "libvirt_volume" "sbd" {
  name  = "${var.base_configuration["prefix"]}-${var.name}${var.hcount > 1 ? "-${count.index  + 1}" : ""}-sbddisk.raw"
  pool  = "${var.base_configuration["pool"]}"
  size  = "${var.sbd_disk_size}"
  count = "${var.hcount}"

  # https://www.w3schools.com/xml/xsl_languages.asp
  # https://libvirt.org/formatstorage.html#exampleVol
  xml {
    xslt = "${file("${var.xmlfile}")}"
  }
}

output "ids" {
  value = "${join(",", libvirt_volume.sbd.*.id)}"
}
