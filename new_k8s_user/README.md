1. Generate key:
openssl genrsa  -out alex.key 2048

2. Generate csr with key from step 1:
openssl req -new -key alex.key -subj "/CN=alex" -out alex.csr

3. Create csr object (see alex.yaml):
kubectl apply -f alex.yaml

4. Check csr and approve it:
kubectl get csr
kubectl certificate approve alex

5. Take user cert from section and decode it:
kubectl get csr alex -o json
...   
  "status": {
        "certificate":
...

echo <certs> |base64 --decode

note: quick way: 
kubectl get csr alex -ojsonpath="{.status.certificate}" | base64 -d  > alex.crt

6. Add to config file and use:
kubectl config set-credentials alex --client-key alex.key --client-certificate alex.crt
kubectl config set-context alex --cluster kubernetes --user alex
