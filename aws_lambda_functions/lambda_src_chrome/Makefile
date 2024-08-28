AWS_ECR_ACCOUNT_ID = 663790350014
AWS_ECR_REGION = ap-southeast-2

# Will get them via GitHub Actions or get it from the AWS Console
ECR_REPOSITORY ?=
ECR_REGISTRY ?= 
TAG ?=


.PHONY : docker/build docker/push docker/run docker/test

docker/build :
  docker build . -t $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(TAG)


docker/push : docker/build
  # aws ecr get-login-password --region $(AWS_ECR_REGION) | docker login --username AWS --password-stdin $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com
  docker push $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)


docker/run :
  docker run -p 9000:8080 $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)


docker/test :
  curl -XPOST 'http://localhost:9000/2015-03-31/functions/function/invocations' -d '{}'