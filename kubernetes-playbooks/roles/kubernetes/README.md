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
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6ImJ2UTYtcGMtTUNweXdyeXJzZTIxeEtJcllwZEktZTBiQm95OWgwdm1aV3cifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLXBwbmJ3Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIyYWQyN2I3Yy04Yzk3LTQyYTQtYWU3Ni01ZmMwNzU5MmNkN2MiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.H-aRkh7m8D56g9xprMuz9PHzYhPc1mNc9m2_N-P85PchURC6s-1fS6mLoQytRQwlQE3dFi0dahq7whTEH_-mKZrhOAxNaBZThxUIm8wpPuhO6f1VdYZPIA8zqHgokCbcR1yepIXatRWq2cWMRlKDxwfN6-cVq2X2-15ArAV8nHSRkH8RhWJFKTgqy_3rdvi5nQn8tODAC3j6ArJCNRLWD250lTOrM9eX_Y8bBthLc09znzAtNbwvEU0Vk-YhtNixWf_v3dpiHks62KxNS0JmKXxMmu4l_GIOBOsUiqq0a3zUSrHGqRT6929AGTBeZgq7SiNz1_zr-TyZJX35jvStYQ
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
