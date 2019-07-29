include:
{% if grains['provider'] == 'libvirt' %}
  - default.minimal
{% endif %}
  - default.hostname
  - default.repos
  - default.pkgs
{% if grains['provider'] == 'libvirt' %}
  - default.timezone
refresh_repos:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
    - retry:
        attempts: 3
        interval: 15
{% endif %}
