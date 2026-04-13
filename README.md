# Stock Trek Infrastructure

This repository contains the Terraform infrastructure for the Stock Trek platform.

## Overview

The infrastructure is organized into the `live/` directory which contains the main Terraform configuration for production resources.

## Live Infrastructure (`live/`)

The `live/` directory contains Terraform configuration for the following AWS resources:

### Core Services

1. **ECR Repository** (`ecr.tf`)
   - Amazon Elastic Container Registry repository for the algorithm-runner container
   - Image tag mutability is set to immutable with wildcard exclusion for "master" tags
   - Automatic image scanning on push

2. **Lambda Functions** (`lambda-function.tf`)
   - AWS Lambda functions for algorithm execution with container image deployment
   - Functions: `stock-trek-compile-rust-check` and `stock-trek-compile-rust-save`
   - Each function is configured with 2GB memory and 30-second timeout
   - Public function URLs with CORS configuration for web access

3. **Website Hosting** (`website.tf`)
   - S3 bucket with CloudFront CDN for static website hosting
   - Custom domain: `stock-trek.com`
   - GitHub OIDC integration for automated deployments

4. **IAM Roles and Policies** (`iam.tf`)
   - `StockTrekPushImage`: Role for GitHub Actions to push images to ECR and update Lambda functions
   - `StockTrekRunLambda`: Execution role for Lambda functions with ECR pull permissions
   - Fine-grained policies for logging, image management, and Lambda updates

### Supporting Configuration

- **Providers** (`providers.tf`): AWS providers for eu-west-1 (primary) and us-east-1 (CloudFront)
- **Variables** (`variables.tf`): Configuration variables including `algorithm_runner_image_tag`
- **Locals** (`locals.tf`): Common values like domain names, repository names, and handler lists
- **Outputs** (`outputs.tf`): Terraform outputs including Lambda URLs and website details
- **Policy Documents** (`policy-documents.tf`): IAM policy definitions
- **OIDC Configuration** (`oidc.tf`): GitHub OIDC provider setup

## Deployment

The infrastructure uses Terraform with an S3 backend for state management. GitHub Actions workflows in the repository automate deployment of changes.

### State Management
- Terraform state is stored in S3 bucket: `state.stock-trek.com`
- State file location: `live/terraform.tfstate`
- Region: eu-west-1

### GitHub Integration
- OIDC authentication for secure AWS access from GitHub Actions
- Automated website deployments from the `website` repository
- Automated container image pushes from the `algorithm-runner` repository

## Purpose

This infrastructure supports the Stock Trek platform by providing:
- Container registry for algorithm execution environments
- Serverless compute for algorithm compilation and execution
- Static website hosting for the frontend application
- Secure IAM roles for automated deployments
- Scalable architecture with AWS managed services