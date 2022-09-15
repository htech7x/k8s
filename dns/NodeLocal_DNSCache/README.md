1.

kubedns=`kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}`
domain=<cluster-domain> 
localdns=<node-local-address>

Note:
<cluster-domain> is "cluster.local" by default. To check it run "kubectl describe cm coredns -n kube-system"
<node-local-address> is the local listen IP address chosen for NodeLocal DNSCache.
The local listen IP address for NodeLocal DNSCache can be any address that can be guaranteed to not collide with any existing IP in your cluster. It's recommended to use an address with a local scope, for example, from the 'link-local' range '169.254.0.0/16' for IPv4 or from the 'Unique Local Address' range in IPv6 'fd00::/8'.


Example:
kubedns=`kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}`
domain=cluster.local
localdns=169.254.20.10


2. 

If kube-proxy is running in IPTABLES mode:

sed -i "s/__PILLAR__LOCAL__DNS__/$localdns/g; s/__PILLAR__DNS__DOMAIN__/$domain/g; s/__PILLAR__DNS__SERVER__/$kubedns/g" nodelocaldns.yaml

Note: You dont need to set "__PILLAR__CLUSTER__DNS__" and __PILLAR__UPSTREAM__SERVERS__ manually
__PILLAR__CLUSTER__DNS__ and __PILLAR__UPSTREAM__SERVERS__ will be populated by the node-local-dns pods. In this mode, the node-local-dns pods listen on both the kube-dns service IP as well as <node-local-address>, so pods can look up DNS records using either IP address.


Note:
After deploying node-local-dns nothing changes in "resolv.conf" for the pods.
Pods will still have IP of kube-dns service(by default 10.96.0.10)
Dont expect to see IP of the node-local-dns in resolv.conf

Example:
```
kubectl exec -it nginx-f89759699-2c8zw -- cat /etc/resolv.conf

search default.svc.cluster.local svc.cluster.local cluster.local
nameserver 10.96.0.10
options ndots:5
```

3. Add "log" to cm "node-local-dns" and "coredns" to see all requests:

kubectl edit cm coredns -n kube-system
kubectl edit cm node-local-dns -n kube-system

```
apiVersion: v1
data:
  Corefile: |
    cluster.local:53 {
        log                        #<--- this line
        errors
...

4. Check logs:

kubectl logs --namespace=kube-system -l k8s-app=node-local-dns -f   # this is for node-local-dns
...
[INFO] 192.168.172.182:56534 - 32930 "A IN kubernetes.default.svc.cluster.local. udp 54 false 512" NOERROR qr,aa,rd 106 0.002107294s
[INFO] 192.168.172.182:55427 - 56742 "AAAA IN kubernetes.default.svc.cluster.local. udp 54 false 512" NOERROR qr,aa,rd 147 0.000846898s
...

5. In case you want to check log for one "node-local-dns" pod keep in mind you need to have testing pod and "node-local-dns" pod scheduled on the same node to see requests in the log





