1. To use hpa you need to have "server-metric" in k8s cluster:
https://github.com/kubernetes-sigs/metrics-server

2. Create k8s objects that have replication(e.g. deployment) with resource request(e.g CPU) for the containers
3. Create k8s object "HorizontalPodAutoscaler"

