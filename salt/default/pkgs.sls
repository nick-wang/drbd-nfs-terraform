{% if grains.get('additional_packages') %}
install_additional_packages:
  pkg.latest:
    - pkgs:
{% for package in grains.get('additional_packages') %}
      - {{ package }}
{% endfor %}
    - require:
      - sls: default.repos
{% endif %}
