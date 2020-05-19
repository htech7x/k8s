1. Restore from snapthot:


etcdctl --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key --endpoints=127.0.0.1:2379 --name=master --data-dir=/var/lib/etcd-from-backup --initial-cluster=master=https://127.0.0.1:2380 --initial-cluster-token=etcd-cluster-1 --initial-advertise-peer-urls=https://127.0.0.1:2380 snapshot restore /dir_for_shapshot/shapshot_name.db

"--data-dir /var/lib/etcd-from-backup" # where the snapshot will be restored


output example:
2020-05-19 21:20:17.841827 I | mvcc: restore compact to 2520
2020-05-19 21:20:17.863341 I | etcdserver/membership: added member e92d66acd89ecf29 [https://127.0.0.1:2380] to cluster 7581d6eb2d25405b

2. Edit /etc/kubernetes/manifests/etcd.yaml


  1. change  "--data-dir=/var/lib/etcd" to "--data-dir=/var/lib/etcd-from-backup"
  2. add "--initial-cluster-token=etcd-cluster-1"
  3. change "volumeMounts: - mountPath: /var/lib/etcd" to "volumeMounts: - mountPath: /var/lib/etcd-from-backup"
  4. change "hostPath: path: /var/lib/etcd" to "hostPath: path: /var/lib/etcd-from-backup"

3. Wait until "etcd" pod will be recreated

   docker ps -a |grep etcd
