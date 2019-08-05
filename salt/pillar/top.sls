base:
  'role:drbd':
    - match: grain
    - drbd
{% if grains['drbdnfs'] == 'cluster' %}
    - cluster
{% endif %}
