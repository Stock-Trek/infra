# Stock Trek Infrastructure

This repository contains Terraform configurations for managing the AWS infrastructure for Stock Trek.

## Overview

Stock Trek is a stock market analysis and tracking platform. This infrastructure repository manages:
- AWS S3 website hosting for the frontend
- AWS Lambda functions for backend services
- AWS ECR repositories for container images
- IAM roles and policies for GitHub Actions CI/CD

## Repository Structure

```
├── bootstrap/          # Initial bootstrap infrastructure (S3 state bucket, IAM roles)
├── live/              # Main production infrastructure
│   ├── website.tf     # S3 website configuration
│   ├── ecr.tf         # ECR repositories
│   ├── lambda-function.tf  # Lambda functions
│   ├── iam.tf         # IAM roles and policies
│   ├── oidc.tf        # OIDC configuration for GitHub Actions
│   └── ...
└── README.md          # This file
```

## Infrastructure Components

### Bootstrap
The `bootstrap/` directory contains Terraform configuration for initial infrastructure setup:
- S3 bucket for Terraform state storage (`state.stock-trek.com`)
- IAM roles for GitHub Actions OIDC authentication

### Live Infrastructure
The `live/` directory contains the main production infrastructure:

1. **Website Hosting**
   - S3 bucket for static website hosting at `stock-trek.com`
   - CloudFront distribution for CDN
   - Route 53 DNS configuration
   - ACM SSL certificate

2. **Container Registry**
   - ECR repositories for Docker images
   - Currently hosts: `algorithm-runner`

3. **Lambda Functions**
   - Serverless functions for backend services
   - Handlers: `check`, `save`

4. **IAM Configuration**
   - Roles for GitHub Actions:
     - `StockTrekPushImage`: Push Docker images to ECR
     - `StockTrekRunLambda`: Deploy Lambda functions
     - `StockTrekUpdateWebsite`: Update S3 website

## GitHub Actions Integration

This infrastructure supports GitHub Actions CI/CD through OIDC authentication:

- **Repository**: `NathanJAdams/stocks/*`
- **OIDC Provider**: GitHub (`token.actions.githubusercontent.com`)
- **AWS Region**: `eu-west-1` (Ireland)

## Getting Started

### Prerequisites
- AWS CLI configured with appropriate credentials
- Terraform v1.0+ installed
- Access to the AWS account

### Initial Setup
1. **Bootstrap Infrastructure** (first time only):
   ```bash
   cd bootstrap
   terraform init
   terraform apply
   ```

2. **Deploy Main Infrastructure**:
   ```bash
   cd live
   terraform init
   terraform apply
   ```

### Environment Variables
The infrastructure uses the following configuration:
- AWS Region: `eu-west-1`
- Domain: `stock-trek.com`
- GitHub Account: `Stock-Trek`
- GitHub Repository: `website`

## Terraform State Management

Terraform state is stored in an S3 bucket:
- Bucket: `state.stock-trek.com`
- Location: `bootstrap/terraform.tfstate` and `live/terraform.tfstate`
- Region: `eu-west-1`
- Encryption: Enabled

## Security

- IAM roles use least-privilege principles
- OIDC authentication eliminates the need for long-lived AWS credentials
- All resources are tagged with `Environment = "Production"`
- S3 buckets have appropriate bucket policies and encryption

## Maintenance

### Updating Infrastructure
1. Make changes to Terraform files
2. Run `terraform plan` to review changes
3. Run `terraform apply` to deploy changes

### Destroying Infrastructure
⚠️ **Warning**: This will delete all resources
```bash
cd live
terraform destroy

cd ../bootstrap
terraform destroy
```

## Related Repositories

- [Stock Trek Website](https://github.com/NathanJAdams/stocks/tree/main/website) - Frontend application
- [AWS S3 Website Module](https://github.com/NathanJAdams/aws_s3_website) - Terraform module for S3 website hosting

## License

This infrastructure code is proprietary and confidential.