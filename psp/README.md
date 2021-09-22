How to use PSP in k8s.

1. Enable "PodSecurityPolicy" in kube-apiserver.
	Add --enable-admission-plugins=NodeRestriction,PodSecurityPolicy" to /etc/kubernetes/manifests/kube-apiserver.yaml

2. After that, you will not be able to create a pod until you have a PSP. So create PSP.

3. Create role,rolebinding for "htech7x" sa in "default" ns.

4. Enjoy
 
NOTE: to check PSP create DEPLOYMENT not POD
pod can be created but if you don't have perm for creating deployment you will see RS in not ready state
"kubectl describe rs" will show more details about the issue
