# Stock Trek Infrastructure

This repository contains Terraform configuration for the Stock Trek infrastructure deployed to AWS.

## Overview

The infrastructure is defined in the `live/` directory and includes:

### AWS Resources

1. **ECR Repository** (`ecr.tf`)
   - `algorithm-runner` repository for container images
   - Image tag mutability with exclusion for `master` tag
   - AES256 encryption and scan-on-push enabled

2. **Lambda Functions** (`lambda-function.tf`)
   - `stock-trek-compile-rust` functions with handlers: `check` and `save`
   - Container-based Lambda functions using ECR images
   - Public function URLs with CORS configuration for the stock-trek.com domain

3. **IAM Roles and Policies** (`iam.tf`, `policy-documents.tf`)
   - `StockTrekPushImage` role for GitHub Actions to push images to ECR
   - `StockTrekRunLambda` role for Lambda execution
   - Policies for ECR access, Lambda updates, and CloudWatch logs

4. **Website Hosting** (`website.tf`)
   - S3 static website with CloudFront distribution
   - Custom domain: `stock-trek.com`
   - GitHub OIDC integration for automated deployments

5. **OIDC Configuration** (`oidc.tf`)
   - GitHub Actions OIDC provider integration
   - Secure role assumption without long-lived credentials

### Configuration

- **Region**: eu-west-1 (primary), us-east-1 (for CloudFront)
- **Domain**: stock-trek.com
- **GitHub Organization**: Stock-Trek
- **State Management**: Remote state stored in S3 bucket `state.stock-trek.com`

### Usage

The infrastructure is managed using Terraform. Key outputs include:

- Lambda function URLs for the `check` and `save` handlers
- Website URL and CloudFront distribution ID
- IAM roles for GitHub Actions deployments

### Deployment

1. GitHub Actions workflows can assume the `StockTrekPushImage` role to push container images to ECR
2. Website updates are deployed via the `StockTrekUpdateWebsite` role
3. Lambda functions are automatically updated when new ECR images are pushed

### Files Reference

- `live/locals.tf` - Centralized configuration variables
- `live/variables.tf` - Input variables
- `live/outputs.tf` - Terraform outputs
- `live/providers.tf` - AWS provider configuration and backend