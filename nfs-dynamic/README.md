issue:
"pvc isn't created"

#kubectl logs -f pod/nfs-client-provisioner-7f7cdb5d4d-lx5df -n nfs
I0524 14:40:34.213137       1 leaderelection.go:185] attempting to acquire leader lease  nfs/my-nfs-provisioner...
...
I0524 14:45:21.488322       1 controller.go:987] provision "default/test-pv" class "nfs-storage-class": started
E0524 14:45:21.493807       1 controller.go:1004] provision "default/test-pv" class "nfs-storage-class": unexpected error getting claim reference: selfLink was empty, can't make reference
...


solution:
add "--feature-gates=RemoveSelfLink=false" flag in the API server static manifest /etc/kubernetes/manifests/kube-apiserver.yaml
...
spec:
  containers:
  - command:
    - kube-apiserver
    - --feature-gates=RemoveSelfLink=false
...
