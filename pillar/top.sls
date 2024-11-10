core:
  '*':
    - podman
    - defaults
  '^.*saltmaster':
    - match: pcre
    - salt-master
