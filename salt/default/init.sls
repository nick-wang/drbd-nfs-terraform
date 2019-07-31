include:
{% if grains['provider'] == 'libvirt' %}
  - default.minimal
{% endif %}
  - default.hostname
  - default.repos
  - default.pkgs
{% if grains['provider'] == 'libvirt' %}
  - default.timezone
  - default.auth_keys
{% endif %}
