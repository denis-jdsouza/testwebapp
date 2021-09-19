## Build Docker Image
Prebuilt Docker image is available [here](https://hub.docker.com/repository/docker/denisjd/testwebapp)\
To build a Docker image for AWS ECR, run the below script\
_Note_: please ensure repository has been created in ECR and corresponding details have been updated in the below script
```
bash build-image.sh
```

## Generate K8s manifests from Helm chart
```
helm template helm-chart/webapp -f helm-chart/webapp/values-mysql.yaml
helm template helm-chart/webapp -f helm-chart/webapp/values-testwebapp.yaml
```

## Deploy webapp on K8s
- To deploy app on AWS EKS\
_prerequisite_: EKS cluster with [AWS Load Balancer Controlle](https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html) deployed
```
helm install helm-chart/webapp -f helm-chart/webapp/values-mysql.yaml
helm install helm-chart/webapp -f helm-chart/webapp/values-testwebapp.yaml
```
- To deploy app on non-EKS K8s clusters (eg: Minikube, Kubeadm) without ingress
```
helm install helm-chart/webapp -f helm-chart/webapp/values-mysql.yaml
helm install helm-chart/webapp -f helm-chart/webapp/values-testwebapp.yaml --set ingress=no --set serviceType=NodePort
```