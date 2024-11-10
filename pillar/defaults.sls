{% if "saltmaster" in grains['host'] %}
automatic_reboot: False
{% else %}
automatic_reboot: True
{% endif %}
