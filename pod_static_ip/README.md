https://docs.projectcalico.org/networking/use-specific-ip

Choose the IP address for a pod instead of allowing Calico to choose automatically.


1. You must be using the Calico IPAM.
2. If you are not sure, ssh to one of your Kubernetes nodes and examine the CNI configuration.

cat /etc/cni/net.d/10-calico.conflist

         "ipam": {
              "type": "calico-ipam"
          },

If it is present, you are using the Calico IPAM. If the IPAM is set to something else, or the 10-calico.conflist file does not exist, you cannot use these features in your cluster.

3. Annotate the pod with "cni.projectcalico.org/ipAddrs" set to a list of IP addresses to assign, enclosed in brackets.

  "cni.projectcalico.org/ipAddrs": "[\"192.168.0.1\"]"

Note:
	the use of the escaped \" for the inner double quotes around the addresses.
	The address must be within a configured Calico IP pool and not currently in use.
	The annotation must be present when the pod is created; adding it later has no effect.
	Note that currently only a single IP address is supported per-pod using this annotation.
