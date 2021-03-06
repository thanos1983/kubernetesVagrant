Role Name Vault
===============

This role will reach to consul Vault and retrieve all the necessary files (CA / password). The role will collect the relevant information based on deployment environment.

CA certificate for Vault
------------------------

The CA used to verify SSL / TLS encryption end to end can be downloaded from [intermediates/ca copy](https://letsencrypt.org/certificates/#intermediates).

Requirements
------------

No prerequicites for this roles it should be running directly.

Role Variables
--------------

Parameters required for this role as loaded from dir vars/main.yml and also from group vars relevant to the environment.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

CA Certificates
---------------

All the certificates necessary for this role are copied from Vault.

Example Playbook
----------------

`ansible-playbook -i inventories/development/hosts.yml -e ansible_user=<username> -e target_hosts=<target_hosts> roles/vault/tasks/main.yml -v`

License
-------

BSD

Author Information
------------------

Athanasios Garyfalos. Email: athanasios.garyfalos@cpan.org
