# test-uts-website-selenium-api

This repository creates an API of running UI tests on the UTS Website similar to <a>https://github.com/Jeffrey-Chung/test-uts-selenium-website</a> and returns the status of tests ran, whether it's successful or not. Initially, it would be just running the test in Google Chrome (chromium), but will expand to running it on FireFox and Microsoft Edge in the future.

## Usage


<b><i>Github Action</b></i>:

- Start the workflow manually (workflow dispatch) and it will provision the Lambda function and the ECR repository to store the Docker Image and build and push the Docker Image to said ECR repository.

<b><i>Running Lambda Function</b></i>:

- Go to the `aws_lambda_functions/lambda_src_chrome` directory and run `make docker/run` to run the Docker Image. This will build and run the Docker image from ECR locally so that you are able to run the Lambda function.

- Then run `make docker/test` in a separate terminal, but the same directory to test and run the Lambda function.

## Directory Structure:
- `aws_lambda_functions`: Contains code of the Lambda functions and any other scripts necessary (i.e. Dockerfile, Bash scripts) to help deploy the function to AWS
    - `lambda_src_chrome`: Code and scripts specifically to run UI tests on Google Chrome
- `.github/workflows`: All CI/CD workflows of this repository
    - `deploy.yml`: Main workflow that builds the Docker image and deploys all necessary resources to AWS. It can also destroy all created resources as well. Triggers via workflow dispatch where you can either choose to `build` all resources or `destroy` them
    - `test_run.yml`: CI workflow as part of PR checks that checks for your Terraform code to ensure that it can provision resources as requested and builds the Docker image of your Lambda code
    - `tfsec.yml`: Another CI workflow as part of PR checks that checks for code vulnerabilities via `tfsec`. Warnings can be disabled in their respective `.tf` files within reason.
- `.tf` files: Terraform files to provision cloud resources to AWS
    - `ecr.tf`: Provisions any resources related to ECR (i.e. ECR repository)
    - `lambda.tf`: Provisions any resources related to the Lambda function, including zipping the `aws_lambda_functions/*` directories
    - `provider.tf`: Stores the providers and Terraform versions needed to run the Terraform files.

### Makefile

- Makefiles are used to run Docker commands to build, push, run and test the Lambda function in the respective ECR repository.
    - `make docker/build`: Runs the `docker build` command to build the Docker image locally
    - `make docker/push`: Also runs the same `docker build` command, but also pushes the image to the ECR repository
    - `make docker/run`: Runs the Docker image locally to create a Docker container of the Lambda function
    - `make docker/test`: Tests and actually runs the Lambda function




<br>