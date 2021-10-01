Role Name: sampleContainerBuildProcess
======================================

This role aims to prepare the Dockerfile in templates based on the variables provided by the relevant vars files in the role. Next it will conect to the Vault and retrieve the necessary credentials for the Azure docker registry. As a next step it will build and push the image to the relevant docker registry (again provided in the vars file). Next step is to run locally the container validate it that it actually runs and the port can listen. Once the tests are passed the container will be removed and the localhost will be pruned.

Requirements
------------

This role requires the user to have pre-installed the following pip packages (docker, cryptography and hvac).

Core package az (azure cli) needs to be installed also in order to interact with the azure arc Docker registry.

Role Variables
--------------

Variables for this role and all roles that are intercalled are defined in the vars file.

Dependencies
------------

This roles will call internally the relevant roles (docker and vault).

Example Playbook
----------------
ansible-playbook \
	--tags sampleContainerBuildProcess \
	--skip-tags never \
	-i inventories/development/hosts.yml \
        -e env_variable=<env_variable> \
	-e target_hosts=<target_hosts> \
	roles/sampleContainerBuildProcess/tasks/main.yml -v

Ansible Vault Variables in file
-------------------------------
In order to produce the encrypted string the user needs to follow this syntax:

```bash
$ ansible-vault encrypt_string '<my secret value to encrypt>' --name '<my key to use in vars file>' --vault-password-file a_password_file # it can be defined also in ansible.cfg
```

Sample of encryption
--------------------
```bash
ansible-vault encrypt_string 'my secret value to encrypt' --name 'testKey'                                      
testKey: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          36386233346435343166356431633138646633323061373132343839333937663266363464666634
          3564386334613936303761346264343733633464323235610a663061396462666466633533343461
          31636461336331636633356566663432303830343739633538643062623332333237373235336333
          3638333161643763330a363135643435373836613631326537333766356331656464633835363062
          61393364396561623933663938346137366532376261376164623739373161396638
Encryption successful
```
The user now it can place this string in vars file e.g:

```bash
mySecrets:
  testKey: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          36386233346435343166356431633138646633323061373132343839333937663266363464666634
          3564386334613936303761346264343733633464323235610a663061396462666466633533343461
          31636461336331636633356566663432303830343739633538643062623332333237373235336333
          3638333161643763330a363135643435373836613631326537333766356331656464633835363062
          61393364396561623933663938346137366532376261376164623739373161396638
```
The string now can be retrieved e.g. `mySecrets.testKey` assuming that the user provides the vault password as stding or in a file (which also can be defined in ansible.cfg).

Official documentation [Use encrypt_string to create encrypted variables to embed in yaml](https://docs.ansible.com/ansible/2.9/user_guide/vault.html#use-encrypt-string-to-create-encrypted-variables-to-embed-in-yaml).

License
-------

BSD

Author Information
------------------

Athanasios Garyfalos. Email: garyfalos@cpan.org
