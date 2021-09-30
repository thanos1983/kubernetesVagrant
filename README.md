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
kubectl --kubeconfig kubernetes-playbooks/.kube/config get nodes  
NAME           STATUS   ROLES    AGE     VERSION
k8s-master     Ready    master   6m2s    v1.21.5
k8s-worker-1   Ready    worker   3m46s   v1.21.5
k8s-worker-2   Ready    worker   107s    v1.21.5
```

## Sample of pods with Cilium as Network element, NGINX as Ingress Controller and CRI-O as socket:
```bash
kubectl --kubeconfig kubernetes-playbooks/.kube/config get pods -A
NAMESPACE                NAME                                         READY   STATUS      RESTARTS   AGE
cri-o-metrics-exporter   cri-o-metrics-exporter-64847968cd-2qv9c      1/1     Running     0          6m17s
ingress-nginx            ingress-nginx-admission-create-dr2vz         0/1     Completed   0          93s
ingress-nginx            ingress-nginx-admission-patch-xnksn          0/1     Completed   2          93s
ingress-nginx            ingress-nginx-controller-5486956f45-s8cmx    1/1     Running     0          93s
kube-system              cilium-2wfpp                                 1/1     Running     0          2m30s
kube-system              cilium-9f462                                 1/1     Running     0          6m26s
kube-system              cilium-fs2r4                                 1/1     Running     0          4m29s
kube-system              cilium-operator-78f45675-8btlp               1/1     Running     0          6m26s
kube-system              cilium-operator-78f45675-8mlgz               1/1     Running     0          6m26s
kube-system              coredns-558bd4d5db-b4lv6                     1/1     Running     0          5m24s
kube-system              coredns-558bd4d5db-h4grm                     1/1     Running     0          5m39s
kube-system              etcd-k8s-master                              1/1     Running     0          6m36s
kube-system              kube-apiserver-k8s-master                    1/1     Running     0          6m36s
kube-system              kube-controller-manager-k8s-master           1/1     Running     0          6m36s
kube-system              kube-proxy-2zh45                             1/1     Running     0          4m29s
kube-system              kube-proxy-hnj7k                             1/1     Running     0          6m26s
kube-system              kube-proxy-whzrq                             1/1     Running     0          2m30s
kube-system              kube-scheduler-k8s-master                    1/1     Running     0          6m36s
kube-system              metrics-server-7f64dfcd8b-dw9n9              1/1     Running     0          6m14s
kubernetes-dashboard     dashboard-metrics-scraper-856586f554-cmxn7   1/1     Running     0          6m26s
kubernetes-dashboard     kubernetes-dashboard-67484c44f6-xvc5j        1/1     Running     0          6m26s
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
