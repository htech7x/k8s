https://github.com/bitnami-labs/sealed-secrets

You need 2 components for sealed secret:

1. "ClientCLI" -> used to generate encrypted secrets. No one decrypts except the secret controller.
Download the latest version of kubeseal(sealed-secret): https://github.com/bitnami-labs/sealed-secrets/releases

2. "Kubernetes Secret controller"  -> used to decrypt the sealed secret and store it as secret in the Kubernetes Cluster.
You have to install the sealed secret controller on the Kubernetes cluster:
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v<release>/controller.yaml


How to create sealed secret:

1. Create template: 

example "secret-template.yaml"

2. Create sealed secret from "secret-template.yaml":

cat secret-template.yaml | kubeseal \
    --controller-namespace kube-system \
    --controller-name sealed-secrets-controller \
    --format yaml \
    > sealed-secret.yaml

NOTE: manifest "sealed-secret.yaml" contains encrypted data for the secret. 
Now this sealed secret file can be pushed to the Git or other public repo and can be executed using the "kubectl apply".

3. Apply sealed-secret.yaml:

kubectl apply -f sealed-secret.yaml

NOTE: keep in mind that the sealed secret decrypts and stores the secret object in the Kubernetes cluster.
So if anyone had access to the Kubernetes cluster, can see the sensitive information by viewing the secret object.

kubectl get secret <secret_name> -o yaml



