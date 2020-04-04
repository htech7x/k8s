#How to check RBAC



kubectl auth can-i get deployments -n default --as system:serviceaccount:default:<name_sa>
                    |       |            |                                  |      |
                   verb   object     namespace                             ns   serviceaccount


example:
kubectl auth can-i get secrets -n default --as system:serviceaccount:default:dev
kubectl auth can-i get sa -n default --as system:serviceaccount:default:dev
kubectl auth can-i get pod -n default --as system:serviceaccount:default:dev
