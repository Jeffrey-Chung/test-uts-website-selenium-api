AWS_ECR_ACCOUNT_ID = 663790350014
AWS_ECR_REGION = ap-southeast-2
APP_NAME = tf-aws-jchung-lambda-function-firefox

# Will get them via GitHub Actions or get it from the AWS Console
ECR_REPOSITORY ?=
TAG ?=


.PHONY : docker/build docker/push docker/run docker/test

docker/build :
	docker build . -t $(APP_NAME):$(TAG)


docker/push : docker/build
	# aws ecr get-login-password --region $(AWS_ECR_REGION) | docker login --username AWS --password-stdin $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com
	docker tag $(APP_NAME):$(TAG) $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)
	docker push $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)


docker/run :
	aws ecr get-login-password --region $(AWS_ECR_REGION) | docker login --username AWS --password-stdin $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com
	docker run -p 9000:8080 $(AWS_ECR_ACCOUNT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(ECR_REPOSITORY):$(TAG)

docker/test :
	curl -XPOST 'http://localhost:9000/2015-03-31/functions/function/invocations' -d '{}'