Install metric-servers:
git clone https://github.com/linuxacademy/metrics-server
kubectl apply -f ~/metrics-server/deploy/1.8+/

Check metrics server:
kubectl get --raw /apis/metrics.k8s.io/
