How to use PSP in k8s.

1. Enable "PodSecurityPolicy" in kube-apiserver.
	Add --enable-admission-plugins=NodeRestriction,PodSecurityPolicy" to /etc/kubernetes/manifests/kube-apiserver.yaml

2. After that, you will not be able to create a pod until you have a PSP. So create PSP.

3. Create role,rolebinding for "htech7x" sa in "default" ns.

4. Enjoy
 
