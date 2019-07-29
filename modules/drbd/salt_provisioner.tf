# This file contains the salt provisioning logic.
# It will be executed if 'provisioner' is set to 'salt' (default option) and the
# libvirt_domain.domain (hana_node) resources are created (check triggers option).

terraform {
  required_version = "~> 0.11.7"
}

# Template file to launch the salt provisioning script
data "template_file" "salt_provisioner" {
  template = "${file("${var.salt_path}/salt_provisioner_script.tpl")}"

  vars {
    regcode = "${var.reg_code}"
  }
}

resource "null_resource" "drbd_provisioner" {
  count = "${var.provisioner == "salt" ? libvirt_domain.domain.count : 0}"

  triggers = {
    cluster_instance_ids = "${join(",", libvirt_domain.domain.*.id)}"
  }

  connection {
    host     = "${element(libvirt_domain.domain.*.network_interface.0.addresses.0, count.index)}"
    user     = "root"
    password = "linux"
  }

  provisioner "file" {
    source      = "${var.salt_path}"
    destination = "/tmp"
  }

  provisioner "file" {
    content     = "${data.template_file.salt_provisioner.rendered}"
    destination = "/tmp/salt_provisioner.sh"
  }

  provisioner "file" {
    content = <<EOF

provider: libvirt
role: drbd
name_prefix: ${var.name}
hostname: ${var.base_configuration["prefix"]}-${var.name}${var.hcount > 1 ? "-${count.index + 1}" : ""}
domain: ${var.base_configuration["domain"]}
timezone: ${var.base_configuration["timezone"]}
host_nodes: ${var.hcount}
network_address_base: ${local.network_addresses}

drbddev: ${var.drbddev}
partitions:
  1:
    start: 1
    end: 30%
  2:
    start: 30%
    end: 100%

${var.grains}

EOF

    destination = "/tmp/grains"
  }

  provisioner "remote-exec" {
    inline = [
      "${var.background ? "nohup" : ""} sh /tmp/salt_provisioner.sh > /tmp/provisioning.log ${var.background ? "&" : ""}",
      "return_code=$? && sleep 1 && exit $return_code",
    ] # Workaround to let the process start in background properly
  }
}
