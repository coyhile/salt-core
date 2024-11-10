hile:
  user.present:
    - fullname: Coy Hile
    - shell: /bin/bash
    - home: /home/hile

hile_sshkeys:
  ssh_auth.present:
    - user: hile
    - enc: ed25519
    - comment: hile@chromebook
    - names:
        - AAAAC3NzaC1lZDI1NTE5AAAAIDhCU+4HV7gKT9NSp9LFjbPl/9brOWAaKCuLLTzAe7ie

sudoers:
  file.managed:
    - name: /etc/sudoers.d/users
    - contents: | 
        hile ALL=(ALL:ALL) NOPASSWD:ALL

