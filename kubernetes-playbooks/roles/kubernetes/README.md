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
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IndyNkU4YU5IbWlwNHRLZzVrclAwM2pPR1dObVRmZThsVnVJTmpMSURZUncifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLWNwa3YyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJmN2Y2YTdlMS03NDEyLTQ0MzEtOTk1YS1jNjE4ODk5NzQ0OWMiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.W49pFwdRpNPlhRBCiOP0Z3BBWJMrvpY_FVtUnJXn3w6oXyiWCOkMo7JJn-0mMftlWxK0MCAmrv1RJwV3yHA3MlWsgTnAxI-jdu1By8NGXDMa0SzymKkyqgAnXijrqN6xgGnjVB0OGQ_tAobtxC4otxTm3_e_zLAfy6sCfa9qcPDmWxBveRpmwWvwQawwvRs8F2RW_9uCySe6ltYC_r_bVIXXC3VB1bAw8k_N2xbTPrZlUlAiUfBiVyfEEBUeao19DKU63d-UHE2CMlfZ6qwFap3W5Km_BiUEgjdNsuoaKprgA-upeE-pNFaMxG7Yf6giP37NKWXlN8nEInhD8V_ErQ
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

## In case the user wants to pull images from private Docker registry the documentation on how we make the secret is here from the official page (Pull an Image from a Private Registry)[https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/].

Sample of how to encode / decode base64 strings in terminal:

```bash
echo -n 'linuxhint.com' | base64
bGludXhoaW50LmNvbQ==
echo 'bGludXhoaW50LmNvbQ==' | base64 --decode
linuxhint.com%   
```

We use `-n` flag to force echo not to use `\n` new line character at the end of the string.

License
-------

BSD

Author Information
------------------

Athanasios Garyfalos
