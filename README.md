# Stock Trek Infrastructure

This repository contains Terraform configuration for the Stock Trek infrastructure.

## Live Environment

The `live/` directory contains Terraform modules for the production infrastructure:

### AWS Resources

- **ECR Repository**: Container registry for the algorithm-runner service
- **Lambda Functions**: Rust compilation handlers (`check` and `save`) deployed as container images
- **S3 Website**: Static website hosting for stock-trek.com with CloudFront CDN
- **IAM Roles**: 
  - `StockTrekPushImage`: GitHub Actions role for pushing images to ECR and updating Lambda functions
  - `StockTrekRunLambda`: Lambda execution role
  - `StockTrekUpdateWebsite`: GitHub Actions role for updating the website

### GitHub Integration

- **OIDC Provider**: GitHub Actions can assume IAM roles without storing credentials
- **Automated Deployments**: 
  - Website updates from the `website` repository
  - Container image pushes to ECR
  - Lambda function updates

### Configuration

- **Region**: eu-west-1 (Ireland)
- **Domain**: stock-trek.com
- **GitHub Organization**: Stock-Trek
- **State Management**: Remote state stored in S3 bucket `state.stock-trek.com`

### Outputs

- Lambda function URLs for Rust compilation endpoints
- Website URL and CloudFront distribution ID
- IAM role ARNs for GitHub Actions workflows