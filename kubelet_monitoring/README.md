#https://github.com/SUSE/doc-caasp/issues/166
1. Create service account and permissions

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: monitoring

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: monitoring-clusterrole
rules:
- apiGroups: [""]
  resources:
  - nodes
  - nodes/proxy
  - pods
  verbs: ["get", "list"]
- nonResourceURLs: ["/metrics", "/healthz", "/healthz/*"]
  verbs: ["get"]

---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: monitoring-clusterrole-binding
roleRef:
  kind: ClusterRole
  name: monitoring-clusterrole
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: ServiceAccount
  name: monitoring
  namespace: default


2. kubectl describe sa monitoring |grep -i token
3. kubectl describe secret monitoring-token-6x7sb
4. curl -k https://ip_node:10250/healthz --header "Authorization: Bearer <sa_token_from_step3>"
