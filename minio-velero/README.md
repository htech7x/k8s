How to install Velero + Minio


---- Install Minio:
https://min.io/docs/minio/kubernetes/upstream/

login to Minio(default creds "minioadmin/minioadmin") and create bucket


---- Install Velero cli:
https://velero.io/docs/v1.11/basic-install/

1. Download the latest release’s tarball:
	https://github.com/vmware-tanzu/velero/releases/latest

2. Extract the tarball:
	tar -xvf <RELEASE-TARBALL-NAME>.tar.gz

3. Move the extracted velero binary to somewhere in your $PATH:


4. Install on Minio:
https://velero.io/docs/v1.11/contributions/minio/


Create a Velero-specific credentials file "credentials-velero" in your Velero directory:
[default]
aws_access_key_id = minioadmin
aws_secret_access_key = minioadmin

Install velero:

velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.2.1 \
    --bucket alnetix \
    --secret-file ./credentials-velero \
    --use-volume-snapshots=false \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://minio.velero.svc:9000


Note: s3Url=... should have minio api endpoint(port 9000), check logs for pod "minio" to see datails
	  creds in "credentials-velero" can be minioadmin|minioadmin(which is default) or you can login to "Minio" and 
	        create "Access Keys" and use them instead of minioadmin|minioadmin. 
	        For example "credentials-velero" can looks like:

	        [default]
			aws_access_key_id = xxxxxx
			aws_secret_access_key = xxxxxxxxxxx


How to work with Velero:

# create backup
	velero backup create new-one
# describe
	velero backup describe new-one
# logs
	velero backup logs new-one
