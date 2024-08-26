APP_NAME = tf-aws-jchung-lambda-function-chrome-ecr-repo
IMAGE_TAG = 0.0.1-locally-built

AWS_ECR_ACCOUNT_ID ?= 663790350014
AWS_ECR_REGION ?= ap-southeast-2
ECR_REPOSITORY = $(APP_NAME)

TAG ?= $(IMAGE_TAG) # Or get it from the AWS Console


.PHONY : docker/build docker/push docker/run docker/test

docker/build :
  docker build . -t $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG) -f aws_lambda_functions/aws_lambda_functions/lambda_src_chrome/Dockerfile


docker/push : docker/build
  aws ecr get-login-password --region $(AWS_ECR_REGION) | docker login --username jeffrey-chung-aws --password-stdin $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com
  docker push $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)


docker/run :
  docker run -p 9000:8080 $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)


docker/test :
  curl -XPOST 'http://localhost:9000/2015-03-31/functions/function/invocations' -d '{}'