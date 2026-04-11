# Stock-Trek Infrastructure

This repository contains Terraform configurations for managing the infrastructure of [Stock-Trek.com](https://stock-trek.com).

## Project Structure

```
.
├── bootstrap/          # Bootstrap infrastructure (Terraform state backend)
│   ├── iam.tf
│   ├── locals.tf
│   ├── oidc.tf
│   ├── policy_documents.tf
│   ├── providers.tf
│   ├── s3.tf
│   └── .terraform.lock.hcl
├── live/              # Main infrastructure deployment
│   ├── bak-ecr.tf
│   ├── bak-lambda-function.tf
│   ├── ecr.tf
│   ├── iam.tf
│   ├── lambda-function.tf
│   ├── locals.tf
│   ├── oidc.tf
│   ├── outputs.tf
│   ├── policy-documents.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── website.tf
│   └── .terraform.lock.hcl
├── .github/
│   └── workflows/
│       └── agent.yml  # GitHub Actions workflow for AI-assisted development
├── .gitignore
└── README.md
```

## Infrastructure Components

### Bootstrap Module (`bootstrap/`)
Sets up the foundational infrastructure required for Terraform state management:
- **S3 Bucket**: `state.stock-trek.com` for storing Terraform state files
- **IAM Roles & Policies**: For GitHub Actions OIDC authentication
- **OIDC Provider**: Enables GitHub Actions to assume AWS roles

### Live Module (`live/`)
Deploys the production infrastructure:
- **S3 Website Hosting**: Static website hosting for stock-trek.com
- **ECR Repositories**: Container registry for `algorithm-runner` images
- **Lambda Functions**: Serverless functions for algorithm execution
- **IAM Roles**: 
  - `StockTrekPushImage`: For pushing images to ECR
  - `StockTrekRunLambda`: For executing Lambda functions
  - `StockTrekUpdateWebsite`: For updating the S3 website
- **OIDC Configuration**: GitHub Actions integration for CI/CD

## Prerequisites

1. **AWS Account**: With appropriate permissions
2. **Terraform**: Version compatible with the configurations
3. **AWS CLI**: Configured with credentials
4. **GitHub Repository**: Connected to the infrastructure

## Deployment Workflow

### 1. Bootstrap Deployment
First, deploy the bootstrap infrastructure to create the Terraform state backend:

```bash
cd bootstrap
terraform init
terraform plan
terraform apply
```

### 2. Main Infrastructure Deployment
After bootstrap is complete, deploy the main infrastructure:

```bash
cd ../live
terraform init
terraform plan
terraform apply
```

## CI/CD Integration

The infrastructure is designed to work with GitHub Actions for automated deployments:

- **GitHub OIDC**: Allows GitHub Actions to assume AWS roles without storing credentials
- **Automated Workflows**: Defined in `.github/workflows/agent.yml`
- **AI-Assisted Development**: Uses `@mariozechner/pi-coding-agent` for automated code changes

### Available GitHub Actions Roles:
1. **Website Updates**: Push to the `website` repository triggers S3 website updates
2. **ECR Image Pushes**: Push to repositories with container images triggers ECR updates
3. **Lambda Deployments**: Code changes trigger Lambda function updates

## Terraform State Management

- **Backend**: S3 bucket (`state.stock-trek.com`) with versioning enabled
- **Encryption**: Server-side encryption with AWS KMS
- **Locking**: State locking enabled for concurrent operations
- **Region**: Primary region is `eu-west-1` (Ireland)

## Security

- **Least Privilege**: IAM roles follow principle of least privilege
- **No Public Access**: S3 buckets block public access
- **Encryption**: All resources use encryption at rest
- **OIDC Authentication**: GitHub Actions use short-lived credentials

## Domain Configuration

- **Primary Domain**: `stock-trek.com`
- **State Bucket**: `state.stock-trek.com`
- **Website**: Hosted on S3 with CloudFront distribution

## Development

### Making Changes
1. Create a feature branch
2. Modify Terraform configurations
3. Run `terraform plan` to review changes
4. Create a pull request
5. Merge after review and approval

### Using the AI Assistant
Mention `@agent` in issues or comments to trigger the AI-assisted development workflow. The agent can:
- Read and analyze code
- Make targeted changes
- Create pull requests with proposed changes

## Troubleshooting

### Common Issues

1. **State Lock Errors**: 
   - Check if another Terraform operation is in progress
   - Manually remove the lock file from S3 if needed

2. **Permission Errors**:
   - Verify IAM role assumptions in GitHub Actions
   - Check OIDC provider configuration

3. **Plan/Apply Failures**:
   - Ensure all required variables are set
   - Check AWS service limits

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes with appropriate testing
4. Submit a pull request

## License

[Add appropriate license information]

## Contact

[Add contact information or links to project documentation]