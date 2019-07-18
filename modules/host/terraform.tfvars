# Change according to the output of ../module/base
base_configuration = {
  prefix = "sle15sp1"
  pool = "ssd"
  #image_id = "/ssddummy/libvirtimages/sle15sp1-baseimage"
  image_name = "sle15sp1-baseimage"
  iprange="192.168.10.10/24,192.168.20.10/24"
  shared_img=0

  # Need to change the network_id after base create, use the real one.
  #network_id = "cdcc2a40-2b05-4afa-b52f-a8ae97ffdb10,d3f4b4cb-4573-4fda-8733-edcc01b1f546"
  network_id = "e0f9cda3-d3da-4676-8710-32e2ac9b59ce"
}

name="nwang"
hcount=2
xmlfile="shareable.xsl"
