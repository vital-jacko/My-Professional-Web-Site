# Jackie Schroeder — Data by Schroeder

A static personal portfolio site hosted on AWS via S3 + CloudFront, with infrastructure defined in Terraform.

## Project Structure

```
├── site/                        # Frontend — deployed to S3
│   ├── index.html               # Single-page app — all tabs, JS, and content
│   ├── styles.css               # All styles
│   └── cloud-background.png     # Hero image
└── infrastructure/
    └── terraform/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Architecture

- S3 — private bucket serving static site content
- CloudFront — CDN with HTTPS, OAC-based S3 access
- ACM — DNS-validated TLS certificate (us-east-1)
- Route 53 — A records for root and `www` pointing to CloudFront

## Frontend Features

- Tab-based SPA navigation with URL hash routing (deep-linkable)
- Animated stat counters on page load
- Copy-to-clipboard on all code blocks
- Scroll-to-top button
- Streamlit & AWS tab — portfolio-style showcase of approach, structure, and deployment experience
- No frameworks, no build step — plain HTML, CSS, and JS

## Deploying

```bash
cd infrastructure/terraform
terraform init
terraform apply
```

### Upload Site Files

```bash
aws s3 sync site/ s3://databyschroeder.com --delete
```

### Invalidate CloudFront Cache (after content updates)

```bash
aws cloudfront create-invalidation --distribution-id <distribution-id> --paths "/*"
```

## Prerequisites

- AWS account with a registered domain and Route 53 hosted zone
- AWS CLI configured (`aws configure`)
- Terraform ≥ 1.5
