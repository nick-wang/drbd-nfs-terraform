include:
{% if grains['ha_factory_repo'] == 'libvirt' %}
  - pre_installation.ha_repos
{% endif %}
  - pre_installation.minion_configuration
