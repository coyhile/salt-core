pkg.upgrade:
  module.run:
    - refresh: True

{% if pillar.get('automatic_reboot', False) == True %}
system.reboot updates:
  module:
    - name: system.reboot
    - run
    - require:
      - module: pkg.upgrade
{% endif %}
