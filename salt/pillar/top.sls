base:
  'role:drbd':
    - match: grain
    - drbd
{% if grains.get('drbdnfs') == 'cluster' %}
    - cluster
{% elif grains.get('drbdnfs') == 'raw' %}
    - nfs
{% endif %}
