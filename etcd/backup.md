"etcdctl" is a command line client for etcd


1. To make use of etcdctl for tasks such as back up and restore, make sure that you set the ETCDCTL_API to 3

    export ETCDCTL_API=3


2. Lists all members in the cluster:

    etcdctl --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key --endpoints 127.0.0.1:2379 member list

output example:
1788363660f99b29, started, master, https://172.17.0.32:2380, https://172.17.0.32:2379

3. Create snapshot:

    etcdctl --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key --endpoints 127.0.0.1:2379 snapshot save /dir_for_shapshot/shapshot_name.db

output example:
Snapshot saved at /tmp/shapshot_name.db 
