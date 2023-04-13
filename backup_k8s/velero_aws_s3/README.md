1. Create S3 bucket on AWS
2. Create IAM user on AWS: https://www.youtube.com/watch?v=IUdkEuvihOk&t=169s

3. Create a Velero-specific credentials file "credentials-velero" in your Velero directory:
[default]
aws_access_key_id = xxxxxx
aws_secret_access_key = xxxxxxxxxxx

4. Install velero:

export BUCKET=alnetix
export REGION=us-east-1

velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.6.0 \
    --bucket $BUCKET \
    --backup-location-config region=$REGION \
    --snapshot-location-config region=$REGION \
    --secret-file ./credentials-velero
