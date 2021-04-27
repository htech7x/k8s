Install metric-servers:

New way:
https://github.com/kubernetes-sigs/metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
or
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

Some issues:
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


error: from the "metric-server" pod log
...    
1 server.go:132] unable to fully scrape metrics: [unable to fully scrape metrics from node worker-1: unable to fetch metrics from node worker-1: Get "https://172.31.8.98:10250/stats/summary?only_cpu_and_memory=true": x509: cannot validate certificate for 172.31.8.98 because it doesn't contain any IP SANs
...

solution:
add to "metrics-server" Deployment:
...
      containers:
      - name: metrics-server
...
        args:
          - --kubelet-insecure-tls # <--- add this line 
...





Old way:
git clone https://github.com/linuxacademy/metrics-server
kubectl apply -f ~/metrics-server/deploy/1.8+/



Check metrics server:
kubectl get --raw /apis/metrics.k8s.io/
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"
