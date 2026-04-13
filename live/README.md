# Live Infrastructure for Stock-Trek

This directory contains Terraform configuration for the production infrastructure of Stock-Trek.

## Overview

The infrastructure manages AWS resources for the Stock-Trek application, including:
- ECR repositories for container images
- Lambda functions for algorithm execution
- IAM roles and policies for GitHub Actions and Lambda execution
- S3 website hosting with CloudFront CDN

## File Structure

### Core Configuration Files

- **`providers.tf`** - AWS provider configuration and Terraform backend setup
- **`locals.tf`** - Local variables and constants used across the configuration
- **`variables.tf`** - Input variables for the Terraform configuration
- **`outputs.tf`** - Output values from the Terraform state

### Resource Definitions

- **`ecr.tf`** - ECR repositories for container images (currently `algorithm-runner`)
- **`lambda-function.tf`** - Lambda functions for algorithm execution with function URLs
- **`iam.tf`** - IAM roles and policies for GitHub Actions (push_image) and Lambda execution (run_lambda)
- **`policy-documents.tf`** - IAM policy documents for various permissions
- **`oidc.tf`** - OIDC provider configuration for GitHub Actions authentication
- **`website.tf`** - S3 website hosting module with CloudFront CDN

### Backup/Archived Files

- **`bak-ecr.tf`** - Archived ECR lifecycle policy configuration (commented out)
- **`bak-lambda-function.tf`** - Archived Lambda permission configurations (commented out)

## Key Resources

### ECR Repositories
- `algorithm-runner` - Container images for algorithm execution

### Lambda Functions
- `stock-trek-compile-rust-check` - Lambda function for checking algorithms
- `stock-trek-compile-rust-save` - Lambda function for saving algorithms

### IAM Roles
- `StockTrekPushImage` - Role for GitHub Actions to push images to ECR
- `StockTrekRunLambda` - Role for Lambda functions to execute
- `StockTrekUpdateWebsite` - Role for GitHub Actions to update the website (managed by module)

### Website
- S3 bucket for static website hosting
- CloudFront distribution for CDN
- Route53 DNS configuration (managed by module)

## Usage

This infrastructure is managed via Terraform with state stored in an S3 bucket. The configuration supports GitHub Actions authentication via OIDC for secure deployments.

## Dependencies

- AWS providers for `eu-west-1` and `us-east-1` regions
- External module: `github.com/NathanJAdams/aws_s3_website.git` for website hosting