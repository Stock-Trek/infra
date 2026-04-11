# Stock-Trek Infrastructure

This repository contains Terraform configurations for managing the AWS infrastructure for [Stock-Trek.com](https://stock-trek.com).

## Project Structure

The project is organized into two main directories:

### `bootstrap/`
Contains the foundational infrastructure that needs to be deployed first:
- S3 bucket for Terraform state storage
- IAM roles and policies
- OIDC provider for GitHub Actions authentication

### `live/`
Contains the main application infrastructure:
- ECR repositories for container images
- Lambda functions
- IAM roles for Lambda execution and image pushing
- Website hosting configuration
- Policy documents for various permissions

## Prerequisites

1. **AWS Account**: You need an AWS account with appropriate permissions
2. **Terraform**: Install Terraform (version compatible with ~>6.22.0 AWS provider)
3. **AWS CLI**: Configured with credentials for the target AWS account
4. **GitHub Repository**: The infrastructure assumes GitHub Actions for CI/CD

## Setup Instructions

### 1. Bootstrap Deployment

The bootstrap infrastructure must be deployed first to create the S3 bucket for Terraform state storage:

```bash
cd bootstrap
terraform init
terraform plan
terraform apply
```

This will create:
- S3 bucket: `state.stock-trek.com` for Terraform state storage
- IAM roles and policies for GitHub Actions OIDC authentication

### 2. Main Infrastructure Deployment

After the bootstrap is complete, deploy the main infrastructure:

```bash
cd ../live
terraform init
terraform plan
terraform apply
```

This will create:
- ECR repositories for container images
- Lambda functions for the algorithm runner
- IAM roles for Lambda execution and ECR image pushing
- Website hosting resources
- OIDC configuration for GitHub Actions

## GitHub Actions Integration

The infrastructure is designed to work with GitHub Actions using OIDC authentication. The following roles are created:

1. **StockTrekPushImage**: Allows GitHub Actions to push images to ECR repositories
2. **StockTrekRunLambda**: Allows GitHub Actions to invoke Lambda functions

The OIDC provider is configured to trust GitHub Actions from the `NathanJAdams/stocks` repository.

## Infrastructure Components

### ECR Repositories
- `algorithm-runner`: Container repository for the algorithm runner application

### Lambda Functions
- Algorithm runner functions with handlers: `check` and `save`

### IAM Roles and Policies
- Fine-grained permissions for GitHub Actions workflows
- Lambda execution roles
- ECR access policies

### Website Hosting
- Static website configuration for stock-trek.com

## Terraform State Management

Terraform state is stored in an S3 bucket with the following configuration:
- Bucket: `state.stock-trek.com`
- Encryption: Enabled
- Region: `eu-west-1`
- State files:
  - `bootstrap/terraform.tfstate`
  - `live/terraform.tfstate`

## Variables and Configuration

### Bootstrap Variables
- `aws_region`: AWS region (default: `eu-west-1`)
- `bare_domain`: Base domain name (default: `stock-trek.com`)
- `oidc_github_*`: OIDC configuration for GitHub Actions

### Live Variables
- `bare_domain`: Base domain name
- `github_account_name`: GitHub account/organization name
- `github_repository_name_website`: Website repository name
- `ecr_repositories`: List of ECR repositories to create
- `algorithm_runner_handlers`: List of Lambda function handlers

## Security

- All Terraform state is encrypted at rest in S3
- IAM roles use least-privilege principles
- OIDC authentication eliminates the need for long-lived AWS credentials
- Policies are defined in separate `policy-documents.tf` files for clarity

## Maintenance

### Updating Infrastructure
To make changes to the infrastructure:

1. Modify the Terraform configuration files
2. Run `terraform plan` to review changes
3. Run `terraform apply` to apply changes

### Destroying Infrastructure
To destroy the infrastructure (use with caution):

```bash
cd live
terraform destroy

cd ../bootstrap
terraform destroy
```

**Note**: Destroying the bootstrap infrastructure will remove the S3 bucket containing Terraform state, making it impossible to manage the infrastructure with Terraform afterwards.

## Troubleshooting

### Common Issues

1. **Permission denied errors**: Ensure your AWS credentials have sufficient permissions
2. **State locking errors**: Check if another Terraform operation is in progress
3. **OIDC configuration issues**: Verify GitHub repository names and OIDC subjects match

### Debugging
- Use `terraform plan -detailed-exitcode` to see what changes will be made
- Check AWS CloudTrail logs for API call failures
- Review Terraform state with `terraform show`

## Contributing

When making changes to the infrastructure:

1. Create a feature branch
2. Make your changes to Terraform configurations
3. Run `terraform fmt` to ensure consistent formatting
4. Test changes in a development environment if possible
5. Submit a pull request with a clear description of changes

## License

This infrastructure code is part of the Stock-Trek project.