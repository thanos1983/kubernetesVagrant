## Table of contents
- [Table of contents](#table-of-contents)
- [General info](#general-info)
    - [Note](#note)
- [Group Vars](#group-vars)
- [Technologies](#technologies)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Destroy the VMs](#destroy-the-vms)
- [Sample of complete cluster](#sample-of-complete-cluster)
- [Where to find the .kube dir](#where-to-find-the-kube-dir)

## General info
This project was created se we can minimize the human interaction / configurations on a new kubernetes (k8s) cluster.
The cluster will have one Master node and two Client nodes. The project will be constantly updated by inluding new packages:

<ul> <li>Ingress Controller (nginx, HaProxy etc)</li> <li>Container Run time Interface (CRI) Containerd / CRI-O</li> <li>TODO Promehtues / Grafana</li> </ul>

#### Note
The project will provide the ability to the users to choose the k8s version, socket e.g. (Containerd / CRI-O) or the Ingress Controller package (NGINX, HaProxy etc).
The variables will be defined on the global file varibles of Ansible.

## Group Vars
On this project we have common group vars for all roles. So all group vars should be common indepently the role. From more information: [Alternative Directory Layout](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#alternative-directory-layout)

## Technologies
Project is created with:
* Ansible version: 2.11.3
* Python version: 3.9.6
* Virtualbox version: 6.1.26r145957
* Vagrant version: 2.2.18

## Prerequisites
The user should install the following packages:
- VirtualBox
- Ansible
- Vagrant
- Kubectl (relevent to the version of the kubernetes)

It is necessary for the user to install the following python3 packages:
- k8s
- openshift
- netaddr
- ansible

Sample on how to install python3 packages:
```bash
python3 -m pip install k8s openshift netaddr -U
```

Sample kubectl version for client only:

```bash
kubectl version --client --short
Client Version: v1.22.1
```

Sample of how to install the packages on MacOS:

```bash
brew tap homebrew/cask
brew install --cask virtualbox
brew install --cask vagrant
```

To install Python3 the user should install it through the official documentation [Installing Python 3 on Mac OS X](https://docs.python-guide.org/starting/install3/osx/).

## Setup
To run this project, prerequicites are Python3, Ansible, Virtuabox, Vagrant. Also is required to have already exchange ssh keys with all destination nodes. Alternatively the user need to add the ssh password in the bash script "deploy.sh". To run the project simply cd in the dir that you have clone it and run:

```bash
$ vagrant up
.
.
.
k8s-client-2               : ok=19   changed=16   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## Destroy the VMs

```bash
$ vagrant destroy -f                   
==> k8s-client-2: Forcing shutdown of VM...
==> k8s-client-2: Destroying VM and associated drives...
==> k8s-client-1: Forcing shutdown of VM...
==> k8s-client-1: Destroying VM and associated drives...
==> k8s-master: Forcing shutdown of VM...
==> k8s-master: Destroying VM and associated drives...
```

## Sample of complete cluster
Sample of complete cluster with 1 Master nodes and 2 Client nodes:

```bash
➜  kubernetesVagrant git:(main) ✗ kubectl --kubeconfig kubernetes-playbooks/.kube/config get nodes  
NAME           STATUS     ROLES                  AGE     VERSION
k8s-client-1   Ready      <none>                 3m18s   v1.22.1
k8s-client-2   NotReady   <none>                 15s     v1.22.1
k8s-master     Ready      control-plane,master   6m30s   v1.22.1
➜  kubernetesVagrant git:(main) ✗ kubectl --kubeconfig kubernetes-playbooks/.kube/config get pods -A
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-58497c65d5-rhdpv   1/1     Running   0          13m
kube-system   calico-node-bnspq                          1/1     Running   0          7m37s
kube-system   calico-node-mnxgq                          1/1     Running   0          13m
kube-system   calico-node-n4dhv                          1/1     Running   0          10m
kube-system   coredns-78fcd69978-qvvwh                   1/1     Running   0          13m
kube-system   coredns-78fcd69978-xrkpl                   1/1     Running   0          13m
kube-system   etcd-k8s-master                            1/1     Running   0          13m
kube-system   kube-apiserver-k8s-master                  1/1     Running   0          13m
kube-system   kube-controller-manager-k8s-master         1/1     Running   0          13m
kube-system   kube-proxy-6s8hz                           1/1     Running   0          7m37s
kube-system   kube-proxy-d4xst                           1/1     Running   0          10m
kube-system   kube-proxy-ttzln                           1/1     Running   0          13m
kube-system   kube-scheduler-k8s-master                  1/1     Running   0          13m
```

## Kuberenets release notes (versions)
The user can refer to the official up to date release page of kubernetes [kubernetes/Releases](https://kubernetes.io/releases/). Once the user decides the Major and Minor version that desires to run the cluster can set these values in the [kubernetes-playbooks/group_vars/all.yml](kubernetes-playbooks/group_vars/all.yml) file.

Sample of configuration:

```bash
kubernetesConfigurations:
  version:
    major: "1.21"
    minor: "5"
  domain: "my.k8s.cluster.com"
  socket: "crio" # crio or containerd
  operatingSystem: "xUbuntu_20.04"
  networkElement: "cilium" # calico, weavenet or cilium
  ingressController: "nginx" # nginx or haproxy
```

## Where to find the .kube dir
The script will automatically download the whole .kube dir at `kubernetes-playbooks` dir. The user will be able to connect to the cluster directly from the directory by using `--kubeconfig kubernetes-playbooks/.kube/config <command here>`.

## Serverless Fnctions
Official documentation can be found here [Fission|https://fission.io/docs/]. The user should be aware that in order to deploy Serverless functionality on the cluster the value true needs to be applied at [group_vars|kubernetes-playbooks/group_vars/all.yml].

## Serverless Client
The user in order to user serverless functions needs to install serverless client locally also. The official documentation for all Operating Systems (OS) [Install Fission CLI|https://fission.io/docs/installation/#install-fission-cli].
