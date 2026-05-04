# Jackie — Personal Professional Website

A static personal portfolio site hosted on AWS via S3 + CloudFront, with infrastructure defined in both AWS CDK (TypeScript) and Terraform.

## Project Structure

```
├── site/                        # Frontend — deployed to S3
│   ├── index.html
│   └── styles.css
└── infrastructure/
    ├── cdk/                     # AWS CDK stack (TypeScript)
    │   └── stack.ts
    └── terraform/               # Terraform alternative
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Architecture

- S3 — private bucket serving static site content
- CloudFront — CDN with HTTPS, OAC-based S3 access
- ACM — DNS-validated TLS certificate (us-east-1)
- Route 53 — A records for root and `www` pointing to CloudFront

## Deploying

### Option A — Terraform

```bash
cd infrastructure/terraform
terraform init
terraform apply -var="domain_name=yourdomain.com" -var="hosted_zone_id=ZXXXXXXXXXXXXX"
```

### Option B — AWS CDK

```bash
cd infrastructure/cdk
npm install
cdk deploy --context domainName=yourdomain.com --context hostedZoneId=ZXXXXXXXXXXXXX
```

### Upload Site Files

```bash
aws s3 sync site/ s3://yourdomain.com --delete
```

## Prerequisites

- AWS account with a registered domain and Route 53 hosted zone
- AWS CLI configured (`aws configure`)
- Terraform ≥ 1.5 **or** Node.js + AWS CDK v2 installed
