{%- from "nfs/map.jinja" import nfs with context -%}
{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

include:
  - drbd.nfs_ready
{% if drbd.salt.promotion == host %}
  - nfs.server
{% endif %}
  - nfs.client
