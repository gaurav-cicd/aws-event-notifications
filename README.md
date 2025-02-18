# AWS S3-SNS-SQS Terraform Setup

## Overview
This Terraform project provisions AWS infrastructure to enable event-driven messaging using **Amazon S3, Amazon SNS, and Amazon SQS**. The setup ensures that whenever an object is uploaded to an S3 bucket, a notification is sent to an SNS topic, which then forwards it to an SQS queue.

## Architecture
- **SNS Topic:** Standard SNS topic that allows an email subscription.
- **S3 Bucket:** Configured with event notifications to trigger SNS on object creation.
- **SQS Queue:** Standard queue subscribed to SNS with a max receive count of 100.
- **IAM Policies:** Ensures appropriate permissions for SNS, SQS, and S3.

## Folder Structure

terraform-s3-sns-sqs/ │── provider.tf # AWS provider configuration │── sns.tf # SNS topic and subscriptions │── sqs.tf # SQS queue, policies, and DLQ │── s3.tf # S3 bucket and event notifications │── variables.tf # Optional Terraform variables │── README.md # Project documentation │── .gitignore # Git ignore file for Terraform

## Prerequisites:
- AWS account with necessary IAM permissions
- Terraform installed (`>=1.0.0`)
- Configured AWS CLI credentials (`aws configure`)

## How to Use
1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/terraform-s3-sns-sqs.git
   cd terraform-s3-sns-sqs

## Initialize Terraform:
terraform init

## Validate and plan the changes:
terraform validate
terraform plan

## Apply the configuration:
terraform apply -auto-approve

## Confirm SNS email subscription:
Check your email (test@xyz.com) for a confirmation link.
Click the link to confirm the subscription.
Cleanup

## To destroy all resources:
terraform destroy -auto-approve