terraform {
    required_version = "~> 0.11.7"
}

provider "libvirt" {
  uri = "${var.qemu_uri}"
}

locals {
  network_card_list = "${split(",", "${var.base_configuration["network_id"]}")}"
  network_iprange   = "${split(",", "${var.base_configuration["iprange"]}")}"
  // FIXME, addresses should get from iprange
  network_addresses = ["192.168.10.10"]
}

resource "libvirt_volume" "main_disk" {
  name             = "${var.base_configuration["prefix"]}-${var.name}${var.hcount > 1 ? "-${count.index  + 1}" : ""}-maindisk"
  base_volume_name = "${var.base_configuration["shared_img"] ? "" : var.base_configuration["prefix"]}-baseimage"
  pool             = "${var.base_configuration["pool"]}"
  count            = "${var.hcount}"
}

// https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/domain.html.markdown
resource "libvirt_domain" "domain" {
  name       = "${var.base_configuration["prefix"]}-${var.name}${var.hcount > 1 ? "-${count.index  + 1}" : ""}"
  memory     = "${var.memory}"
  vcpu       = "${var.vcpu}"
  running    = "${var.running}"
  count      = "${var.hcount}"
  qemu_agent = true

  // copy host CPU model to guest to get the vmx flag if present
  cpu {
    mode = "${var.cpu_model != "" ? "${var.cpu_model}" : "custom"}"
  }

  # FIXME, need to calc the count of drbd_disks to support flexible var.drbd_disk_count
  # May use %{ if xxx } %{ else } %{ endif } or
  #         %{ for xxx } %{ endfor }
  # https://www.terraform.io/docs/configuration/expressions.html
  disk = ["${concat(
    list(
      map("volume_id", "${element(libvirt_volume.main_disk.*.id, count.index)}"),
    ),
    var.additional_disk
  )}"]

  # FIXME: change fixed IP to dynamic IP
  network_interface = ["${list(
    merge(
      map(
        "network_id", "${local.network_card_list[0]}",
        "hostname",   "node${count.index + 1}",
        "mac",        "AA:BB:CC:11:11:3${count.index + 1}",
        "wait_for_lease", true,
      ),
      map(
        "addresses",  "${list("${local.network_addresses[0]}${count.index}")}",
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

  cpu {
    mode = "host-passthrough"
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

output "addresses" {
  // Returning only the addresses is not possible right now. Will be available in terraform 12
  // https://bradcod.es/post/terraform-conditional-outputs-in-modules/
  value = "${libvirt_domain.domain.*.network_interface}"
}

output "diskes" {
  value = "${libvirt_domain.domain.*.disk}"
}

// All xml should be exactly the same, so only show the 1st one
output "xml" {
  value = "${libvirt_domain.domain.0.xml}"
}
