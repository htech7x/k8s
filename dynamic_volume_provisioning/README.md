Local Disk Storage for K8s


1. Install  "local-path-provisioner":

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.24/deploy/local-path-storage.yaml

2. Use sc "local-path" to provision pv
