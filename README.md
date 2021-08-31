## Table of contents
* [General info](#general-info)
* [Group Vars](#group-vars)
* [Technologies](#technologies)
* [Setup](#setup)

## General info
This project was created se we can minimize the human interaction / configurations on the new / fresh nodes.
The following tasks are applied through this playbook:

<ul> <li>containerd</li> <li>crio</li> <li>kubernetes</li> </ul>

#### Note

The user will be defined on the environment variable. The reason that we need to do this is for example support-user should be created on all non-production nodes.
Separate user should be created for production environment (hostnames, user credentials etc).

## Group Vars

On this project we have common group vars for all groups. So all group vars should be common indepently the group. From more information: [Alternative Directory Layout](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#alternative-directory-layout)

## Technologies
Project is created with:
* Ansible version: 2.11.3
* Python version: 3.9.6
	
## Setup
To run this project, prerequicites are Python3, Ansible, Virtuabox, Vagrant. Also is required to have already exchange ssh keys with all destination nodes. Alternatively the user need to add the ssh password in the bash script "deploy.sh". To run the project simply cd in the dir that you have clone it and run:

```
$ vagrant up
.
.
.
k8s-client-2               : ok=19   changed=16   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## Destroy the VMs

```
$ vagrant destroy -f                   
==> k8s-client-2: Forcing shutdown of VM...
==> k8s-client-2: Destroying VM and associated drives...
==> k8s-client-1: Forcing shutdown of VM...
==> k8s-client-1: Destroying VM and associated drives...
==> k8s-master: Forcing shutdown of VM...
==> k8s-master: Destroying VM and associated drives...
```
