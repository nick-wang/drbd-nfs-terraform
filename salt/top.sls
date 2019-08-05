base:
  'role:drbd':
    - match: grain
    - default
    - drbd
{% if grains['drbdnfs'] == 'cluster' %}
    - cluster
{% endif %}
