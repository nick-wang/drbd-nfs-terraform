# Change according to the output of ../module/base
base_configuration = {
  prefix = "sle15sp1"
  pool = "ssd"
  image_source = "/var/lib/libvirt/images/backup-suma/sles15sp1"
  image_id = "/ssddummy/libvirtimages/sle15sp1-baseimage"
  iprange="192.168.10.0/24,192.168.20.0/24"
  shared_img=0

  # Need to change the network_id after base create, use the real one.
  #network_id = "cdcc2a40-2b05-4afa-b52f-a8ae97ffdb10,d3f4b4cb-4573-4fda-8733-edcc01b1f546"
  network_id = "33d11d18-3f6d-483c-895d-ee0ca2a60d0a"
}

name="nwang"
hcount=2
xmlfile="shareable.xsl"
