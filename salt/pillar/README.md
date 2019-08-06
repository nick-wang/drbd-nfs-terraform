# Pillar examples
This folder stores pillar examples to use in the Salt provisioning.

Depending on the provider used to deploy DRBD with/without HA cluster,
the required parameters are slightly different, even though most of them
match.

All the information about how to tune the deployment is available in:
- https://github.com/SUSE/drbd-formula (to manipulate the drbd.sls file)
- https://github.com/SUSE/habootstrap-formula (to manipulate the cluster.sls file)
