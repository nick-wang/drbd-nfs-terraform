# Write before:
  This is still in bleedy edge, not even in alpha release.

# Purpose:
  Quick deploy a cluster for salt-drbd development and deploy.

# Version:
  0.2

# Usage with workspace:
  terraform workspace new xxx
  terraform workspace select xxx

# How to use(libvirt as example):
* Checkout to the branch for specific SUSE version.

* Modify the `REG_CODE`, `REG_CODE_HA` and `email` for sles

* Modify the [variables](./terraform.tfvars) with specific needs

* Modify the [pillar files](./salt/pillar/). eg. *node names* and *IPs*
  > More information, please refer to [README.md](./salt/pillar/README.md)

* Copy one suitable `main.tf.xxx` to `main.tf`

# Known issues:
  Revisit after alpha.

# External issues:
* In resource.libvirt_network.base_network. "bridge" could be omitted when using "nat" mode. however, will fail to create netcard when count >1. Because all netcards will use the same "bridge" name like "virbr1"

# bugs:
* In resource.libvirt_network.base_network. "bridge" could be omitted when using "nat" mode. however, will fail to create netcard when count >1. Because all netcards will use the same "bridge" name like "virbr1"

# TODO:
* salt states to configure DRBD

# Terraform version:
All Terraform configurations were tested with the 0.11.14 and 0.11.10 version
