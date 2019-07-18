terraform {
    required_version = "~> 0.11.7"
}

provider "libvirt" {
  uri = "${var.qemu_uri}"
}

// Need to apply module `base` and `sbd` to test this individually

// Sepreate from "host" module since may have multiple additional_disks including sbd for differnet nodes.
// Create domain here

locals {
  network_card_list = "${split(",", "${var.base_configuration["network_id"]}")}"
  network_iprange   = "${split(",", "${var.base_configuration["iprange"]}")}"
  // Should use 192.168.10.10/24 instead of 192.168.10.0/24 (10.00 doesn't make sense)
  // Then the ips will start from 100, 101, ...
  // Configure more than 10 nodes, should use dynamic IP
  network_addresses = "${element(split("/", local.network_iprange[0]), 0)}"
}

resource "libvirt_volume" "main_disk" {
  name             = "${var.base_configuration["prefix"]}-${var.name}${var.hcount > 1 ? "-${count.index  + 1}" : ""}-drbd-maindisk"
  base_volume_name = "${var.base_configuration["shared_img"] ? "${var.base_configuration["prefix"]}-baseimage" : var.base_configuration["image_name"]}"
  pool             = "${var.base_configuration["pool"]}"
  count            = "${var.hcount}"
}

// FIXME: Only support drbd_disk_count is 1 atm
resource "libvirt_volume" "drbd_disk" {
  name  = "${var.base_configuration["prefix"]}-${var.name}${var.hcount * var.drbd_disk_count > 1 ? "-${count.index  + 1}" : ""}-drbddisk"
  pool  = "${var.base_configuration["pool"]}"
  count = "${var.hcount * var.drbd_disk_count}"
  size  = "${var.drbd_disk_size}"
}

#// https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/domain.html.markdown
resource "libvirt_domain" "domain" {
  name       = "drbd-${var.base_configuration["prefix"]}-${var.name}${var.hcount > 1 ? "-${count.index  + 1}" : ""}"
  memory     = "${var.memory}"
  vcpu       = "${var.vcpu}"
  running    = "${var.running}"
  count      = "${var.hcount}"
  qemu_agent = true

  // Only support to use the 1st sbd at the moment
  disk = ["${concat(
    list(
      map("volume_id", "${element(libvirt_volume.main_disk.*.id, count.index)}"),
      map("volume_id", "${element(libvirt_volume.drbd_disk.*.id, count.index)}"),
      map("volume_id", var.sbd_disk),
    ),
    var.additional_disk
  )}"]

  // copy host CPU model to guest to get the vmx flag if present
  cpu {
    mode = "${var.cpu_model != "" ? "${var.cpu_model}" : "host-passthrough"}"
  }

  # FIXME: change fixed IP to dynamic IP
  network_interface = ["${list(
    merge(
      map(
        "network_id", "${local.network_card_list[0]}",
        "hostname",   "drbd-${var.base_configuration["prefix"]}-${var.name}${var.hcount > 1 ? "-${count.index  + 1}" : ""}",
        "mac",        "",
        "wait_for_lease", true,
      ),
      map(
        "addresses",  "${list("${local.network_addresses}${count.index}")}",
      )
    ))}"]

  #https://libvirt.org/formatdomain.html
  xml {
    xslt = "${file("${var.xmlfile}")}"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

output "information" {
  depends_on = [
    "libvirt_volume.main_disk",
    "libvirt_domain.domain",
  ]

  value = {
    guestname   = "${join(",", libvirt_domain.domain.*.name)}"
  }
}

output "interfaces" {
  // Returning only the addresses is not possible right now. Will be available in terraform 12
  // https://bradcod.es/post/terraform-conditional-outputs-in-modules/
  value = "${libvirt_domain.domain.*.network_interface}"
}

// Only able the show the 1st net_interface if have multple
output "addresses" {
  value = "${flatten(libvirt_domain.domain.*.network_interface.0.addresses)}"
}

output "diskes" {
  value = "${libvirt_domain.domain.*.disk}"
}

// All xml should be exactly the same, so only show the 1st one
output "xml" {
  value = "${libvirt_domain.domain.0.xml}"
}
