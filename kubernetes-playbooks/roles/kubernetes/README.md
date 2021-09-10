Role Name kubernetes
====================

This role is intented to contain all k8s tasks that we will apply on this role.

Requirements
------------

It is necessary for the user to install the following ansible packages:
- k8s
- openshift

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
- Calico documentation [Quickstart for Calico on Kubernetes](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
- Weave-Net official documentation [Integrating Kubernetes via the Addon](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/)

## UI Token
```bash
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IjJOYWhYZVB1RzZWcVA3MFc0UDNnNEg2cjd2a0tpV0lnendISUMtN1FoWDAifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLTR6dGN0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIzYjc1MmE0OC05M2Q3LTRkMTItODZhMS04NTQxYzc2YWUwNWIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.UV2tjDBC91aTGZxnVWNdmoMtE0G0e-8dsQ4p0SCWP44eeJLrytL0cMZQOkh1BauyEY907y_iJuhymx8YVlu6gmuEybbpkV1mEbExkBCd_S3v6wxDlaSWn4msJ_MsaSXxHNjfjZ1eUfGNox851jufgRIzKLqh_3jQ4du3hkc3SDjwGMJO3K2ngeh1JJu50405L1y8_fhqGzPYtUa2atZzXD5ZlBAYX2PXP3QSxC4f_oDbvAVudZ-ptbcjd_T8VC74PHjwvhUNhlbp_xwnHns2KE2dFvVMWoONcGkysuSSljXwptVEax-8IHvs22s2u-9kmhTvueeJKqyv8wwFO9Wd7Q
```

## CRI-O
-----

By default we open the port 9090 for metrics (Prometheus) and also deploy the CRI-O metric pod on the cluster. If the user desires to update the port it can be configured on the file directly [crio.conf](files/crio.conf).

## Important information regarding kubernetes config
-------------------------------------------------

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
