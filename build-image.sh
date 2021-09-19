#!/bin/bash
#Script to build AWS ECR Docker image

ECR_REPO="<ECR Repo URL>"        #eg: <account>.dkr.ecr.<region>.amazonaws.com
ECR_REGION="<ECR Repo Region>"
APP="testwebapp"
IMAGE_TAG="0.1.0"

##### Login to ECR ######
aws ecr get-login-password --region $ECR_REGION | docker login --username AWS --password-stdin $ECR_REPO

##### Build Docker Image and upload to ECR #######
echo "Building Docker image for $APP"

docker build -t $ECR_REPO/$APP:$IMAGE_TAG .
docker push $ECR_REPO/$APP:$IMAGE_TAG

###### Check if Image was successfully created and pushed to ECR ######
IMG=$(aws ecr describe-images --repository-name $APP --image-ids imageTag=$IMAGE_TAG --region $ECR_REGION | wc -l)
if [ "$IMG" == 0 ]; then
	echo "Docker image with tag: $IMAGE_TAG failed to be created and pushed to ECR"
    exit 1
else
	echo "Success Image_tag: $IMAGE_TAG"
fi