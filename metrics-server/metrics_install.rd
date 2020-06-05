Install metric-servers:

New way:
https://github.com/kubernetes-sigs/metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml


error:
	$ kubectl top node
	error: metrics not available yet

solution:
add to "metrics-server" Deployment:
...
      containers:
      - name: metrics-server
...
        args:
          - --kubelet-preferred-address-types=InternalIP
          - --kubelet-insecure-tls
...


Old way:
git clone https://github.com/linuxacademy/metrics-server
kubectl apply -f ~/metrics-server/deploy/1.8+/



Check metrics server:
kubectl get --raw /apis/metrics.k8s.io/
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"
