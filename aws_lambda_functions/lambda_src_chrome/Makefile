AWS_ECR_ACCOUNT_ID = 663790350014
AWS_ECR_REGION = ap-southeast-2
APP_NAME = tf-aws-jchung-lambda-function-chrome
ECR_REPOSITORY = tf-aws-jchung-lambda-function-chrome-ecr-repo

# Will get them via GitHub Actions or get it from the AWS Console
TAG ?=


.PHONY : docker/build docker/push docker/run

docker/build :
	docker build -t $(APP_NAME):$(TAG) .


docker/push : 
	# aws ecr get-login-password --region $(AWS_ECR_REGION) | docker login --username AWS --password-stdin $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com
	docker push $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)


docker/run :
	docker run $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)