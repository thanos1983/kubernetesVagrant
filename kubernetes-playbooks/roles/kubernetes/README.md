Role Name kubernetes
====================

This role is intented to contain all k8s tasks that we will apply on this role.

Requirements
------------

It is necessary for the user to install the following python packages:
- k8s
- openshift
- netaddr
- ansible

Role Variables
--------------

This role will not contain any variables as it is intented to be loaded in an Object Oriented (OO) way. 

Dependencies
------------

No dependencies only the relevant roles that they will be calling these tasks.

Example Playbook
----------------

This playbook is intented to be used by other roles so no documentation on this section.

## Network Elements
----------------
- Calico official documentation [Quickstart for Calico on Kubernetes](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
- Weave-Net official documentation [Integrating Kubernetes via the Addon](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/)
- Cilium official documentation [Installation using Helm](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-helm/#installation-using-helm)

## UI Token
```bash
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IktRdU1YSllfbS0tTnVrdWxUSGtrcWpHbEMyM0NwbnExTVRvRjhXVGREWUEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLW1jZGg1Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI1ZGNhNmE5ZC05NmQwLTRkZWMtODEzYS0yMWY5YTdkMDk1ODEiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.FVuw2BekXBNSM45m-ekrRmmz-fMjctAMiV6XviOHeKRXnejlg0LGU8ZoftxDvkcvJEvsH9fmQKsebLAxJg-wBc-skwOfvZ_0_ONGxtJkZYLv_np6Pr4Ey2Oaxk43XIDZMqSoXdPxbxj-T96TLOeJvB-87MsXBHbLmNmqo-739dawrtib0SmCN3ymSr2AeNyeuXROEM149ETC3eosqqMdKoLU3BKpLyCeKBtfnj9Zmyan-w_Pzv3KkkDBD7Hj3Zx4OR7CCt6xn1Jtuy2EUkIJv3Z6v8OLn1B2INCOmhRMIkmztX4SUSEVXv7iJ57sAnBZTvD4fH6u1VEGMKzxCY5sBw
```

## CRI-O
-----

By default we open the port 9090 for metrics (Prometheus) and also deploy the CRI-O metric pod on the cluster. If the user desires to update the port it can be configured on the file directly [crio.conf](files/crio.conf).

## Important information regarding network config
-------------------------------------------------
```bash
kubectl --kubeconfig kubernetes-playbooks/.kube/config describe apiservice v1beta1.metrics.k8s.io
```


## Important information regarding kubernetes config
----------------------------------------------------

If the user desires to view current kubeadm configurations (from kubeadm init) in order to shape the kubeadm-config file.

```bash
vagrant@k8s-master:~$ kubectl get configMap kubeadm-config -o yaml -n kube-system
apiVersion: v1
data:
  ClusterConfiguration: |
    apiServer:
      certSANs:
      - 192.168.50.10
      extraArgs:
        authorization-mode: Node,RBAC
      timeoutForControlPlane: 4m0s
    apiVersion: kubeadm.k8s.io/v1beta3
    certificatesDir: /etc/kubernetes/pki
    clusterName: kubernetes
    controllerManager: {}
    dns: {}
    etcd:
      local:
        dataDir: /var/lib/etcd
    imageRepository: k8s.gcr.io
    kind: ClusterConfiguration
    kubernetesVersion: v1.22.1
    networking:
      dnsDomain: cluster.local
      podSubnet: 10.85.0.0/16
      serviceSubnet: 10.96.0.0/12
    scheduler: {}
kind: ConfigMap
metadata:
  creationTimestamp: "2021-09-07T09:20:12Z"
  name: kubeadm-config
  namespace: kube-system
  resourceVersion: "210"
  uid: 97619dee-34b2-4d6b-a2a3-7cebfedd420a
```

License
-------

BSD

Author Information
------------------

Athanasios Garyfalos
