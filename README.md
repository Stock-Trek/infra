# Stock Trek Infrastructure

This repository contains the Terraform infrastructure for the Stock Trek application.

## Overview

The infrastructure is organized into two main directories:

### `bootstrap/`
Contains the initial Terraform configuration that sets up the foundational AWS resources needed to manage the main infrastructure:
- S3 bucket for Terraform state storage (`state.stock-trek.com`)
- IAM roles and policies for GitHub OIDC authentication
- Basic security configurations

### `live/`
Contains the main production infrastructure for Stock Trek:

#### AWS Resources
- **ECR Repository**: Container registry for the algorithm-runner Docker images
- **Lambda Functions**: Serverless functions for stock-trek-compile-rust with handlers for `check` and `save` operations
- **Lambda Function URLs**: Public endpoints for the Lambda functions with CORS configuration
- **IAM Roles and Policies**:
  - `StockTrekPushImage`: Role for GitHub Actions to push Docker images to ECR
  - `StockTrekRunLambda`: Execution role for Lambda functions
- **S3 Website**: Static website hosting for stock-trek.com
- **OIDC Configuration**: GitHub Actions authentication for CI/CD pipelines

#### Key Features
- **Immutable Docker Images**: ECR repositories configured with image tag immutability (except for `master` tags)
- **Serverless Architecture**: Lambda functions with container image packaging
- **Static Website**: Hosted on S3 with CloudFront distribution
- **GitHub Actions Integration**: OIDC-based authentication for secure deployments
- **Multi-region Support**: Resources deployed in both `eu-west-1` and `us-east-1` regions

## Infrastructure Details

### ECR (Elastic Container Registry)
- Repository: `algorithm-runner`
- Image tag mutability: Immutable with exclusion for `master` tags
- Encryption: AES256
- Image scanning: Enabled on push

### Lambda Functions
- Function: `stock-trek-compile-rust` with `check` and `save` handlers
- Package type: Container image
- Memory: 2048MB
- Timeout: 30 seconds
- Public URLs with CORS configured for `stock-trek.com` domain

### Website
- Domain: `stock-trek.com`
- Static site hosted on S3 with CloudFront CDN
- Automated deployment via GitHub Actions

### IAM Configuration
- GitHub OIDC integration for secure CI/CD
- Least-privilege policies for ECR push/pull operations
- Lambda execution permissions
- CloudWatch logging access

## Deployment

### Bootstrap
1. Apply the bootstrap Terraform configuration to create the S3 state bucket and initial IAM roles
2. This only needs to be done once per environment

### Main Infrastructure
1. Apply the live Terraform configuration to deploy the full infrastructure
2. GitHub Actions workflows use OIDC authentication to push images and update Lambda functions

## State Management
- Terraform state is stored in S3: `state.stock-trek.com`
- State file location: `live/terraform.tfstate`
- Region: `eu-west-1`
- Encryption: Enabled with KMS
- Versioning: Enabled

## Security
- All resources are tagged with `Environment = "Production"`
- S3 buckets have public access blocked
- ECR images are encrypted at rest
- GitHub Actions use OIDC tokens instead of long-lived credentials
- Least-privilege IAM policies applied to all roles