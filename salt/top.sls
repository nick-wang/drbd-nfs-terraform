base:
  'role:drbd':
    - match: grain
    - default
    - drbd
{% if grains.get('drbdnfs') == 'cluster' %}
    - cluster
{% elif grains.get('drbdnfs') == 'raw' %}
    - nfs.ondrbd
{% endif %}
