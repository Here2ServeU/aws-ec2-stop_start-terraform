# Building an Infrastructure That Will Automate Starting and Stopping EC2 Instances On A Schedule Time

## Introduction:
* 👋 Hey everyone! Welcome back to my GitHub.
* 🎥 This repo shows you how to schedule times to start and stop your EC2 instances.
* 📊 The tools we use for this infrastructure include: ***EventBridge Rules***, ***Lambda***, ***SNS***, ***IAM***, and ***Terraform***. 

## Prerequisites:
* Terraform installed on your local Machine.
* An Account with AWS.
* AWS CLI.

## Steps:
**1. Clone this Repo to your local machine:**
* git clone https://github.com/aws-ec2-stop_start-terraform/
* Decide what runtime you want to use between Python and NodeJS: 
         * cd python-runtime
         * cd nodejs-runtime

**2. Define the input variables:**
* Go to the terraform.tfvars file and change the variables as desired. 

**3. Initialize, Plan, and Apply the Terraform Configurations.**  
* terraform init
* terraform plan
* terraform apply

**4. Clean up**
* terraform destroy

## Troubleshooting:
**EventBridge Rules**: Verify that the EventBridge rules are correctly created in the AWS Management Console under EventBridge -> Rules. Ensure the cron expressions are correct.

**Lambda Permissions**: Ensure the Lambda permissions allow invocation by the EventBridge rules. The aws_lambda_permission resources should handle this.

**Lambda Execution**: Check the CloudWatch Logs for the Lambda functions to see if they are being invoked correctly and if there are any errors during execution.

**SNS Topic Subscription**: Ensure that the email subscription to the SNS topic is confirmed. You should have received an email to t2scloud@gmail.com to confirm the subscription. Without confirmation, the notifications will not be sent.

**IAM Role Permissions**: Ensure the IAM role attached to the Lambda functions has the correct permissions to start and stop instances, as well as publish messages to SNS.

## Outro:
* 🎉 Congrats! You have successfully set up an infrastructure that will automatically start and stop your EC2 instances using Terraform.
* 💬 Leave any questions or comments below; I'll be happy to help!
