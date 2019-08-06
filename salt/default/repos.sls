{% if grains['os_family'] == 'Suse' %}
refresh_repos_default:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
    - retry:
        attempts: 3
        interval: 15
{% endif %}

{% if grains.get('additional_repos') %}
{% for label, url in grains['additional_repos'].items() %}
{{ label }}_repo_default:
  pkgrepo.managed:
    - humanname: {{ label }}
    - baseurl: {{ url }}
    - priority: 120
    - gpgcheck: 0
{% endfor %}
{% endif %}
