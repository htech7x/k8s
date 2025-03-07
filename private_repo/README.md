Create secret:

kubectl create secret docker-registry --docker-server=DOCKER_REGISTRY_SERVER --docker-username=DOCKER_USER --docker-password=DOCKER_PASSWORD --docker-email=DOCKER_EMAIL

example:

kubectl create secret docker-registry my-repo --docker-username htech7x --docker-password password123
