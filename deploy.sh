#!/bin/bash

# Variables
SERVICE_NAME="streamlit-app-service"
REGION="us-east-1"
ECR_REPO_NAME="streamlit-app"

# Create ECR repository if it doesn't exist
aws ecr describe-repositories --repository-names $ECR_REPO_NAME --region $REGION 2>/dev/null || \
aws ecr create-repository --repository-name $ECR_REPO_NAME --region $REGION

# Get ECR login token
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$REGION.amazonaws.com

# Build and tag image
docker build -t $ECR_REPO_NAME .
docker tag $ECR_REPO_NAME:latest $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$REGION.amazonaws.com/$ECR_REPO_NAME:latest

# Push image to ECR
docker push $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$REGION.amazonaws.com/$ECR_REPO_NAME:latest

echo "Image pushed to ECR. You can now create an App Runner service using this image."
echo "ECR Image URI: $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$REGION.amazonaws.com/$ECR_REPO_NAME:latest"