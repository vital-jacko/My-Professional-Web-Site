# How To — Data by Schroeder

## Table of Contents
- [First Time Setup](#first-time-setup)
- [Deploy Infrastructure](#deploy-infrastructure)
- [Upload Site Files](#upload-site-files)
- [Update Site Content](#update-site-content)
- [Update Infrastructure](#update-infrastructure)
- [Invalidate CloudFront Cache](#invalidate-cloudfront-cache)
- [Tear Down Infrastructure](#tear-down-infrastructure)

---

## First Time Setup

### 1. Confirm AWS credentials are working
```cmd
aws sts get-caller-identity
```

### 2. Initialize Terraform (only needed once)
```cmd
cd c:\Users\jacki\Documents\GitHub\My-Professional-Web-Site\infrastructure\terraform
terraform init
```

---

## Deploy Infrastructure
Run this when setting up for the first time or after changing any `.tf` files.

```cmd
cd c:\Users\jacki\Documents\GitHub\My-Professional-Web-Site\infrastructure\terraform
terraform plan
terraform apply
```
- `terraform plan` — previews what will be created/changed, no changes made
- `terraform apply` — deploys the changes, type `yes` when prompted

After apply completes, note the outputs:
```
cloudfront_domain          = "dxxxxxxxxxxxxx.cloudfront.net"
cloudfront_distribution_id = "EXXXXXXXXXXXXX"
s3_bucket_name             = "databyschroeder.com"
```

---

## Upload Site Files
Run this after deploying infrastructure for the first time, or any time you update `index.html` or `styles.css`.

```cmd
cd c:\Users\jacki\Documents\GitHub\My-Professional-Web-Site
aws s3 sync site/ s3://databyschroeder.com --delete
```

---

## Update Site Content
When you make changes to `index.html` or `styles.css`:

**Step 1 — Sync files to S3:**
```cmd
cd c:\Users\jacki\Documents\GitHub\My-Professional-Web-Site
aws s3 sync site/ s3://databyschroeder.com --delete
```

**Step 2 — Invalidate CloudFront cache so changes show immediately:**
```cmd
aws cloudfront create-invalidation --distribution-id EXXXXXXXXXXXXX --paths "/*"
```
Replace `EXXXXXXXXXXXXX` with your actual distribution ID from the Terraform outputs.

---

## Update Infrastructure
When you make changes to any `.tf` files:

```cmd
cd c:\Users\jacki\Documents\GitHub\My-Professional-Web-Site\infrastructure\terraform
terraform plan
terraform apply
```

---

## Invalidate CloudFront Cache
If your site changes aren't showing up after an S3 sync, force CloudFront to pull fresh files:

```cmd
aws cloudfront create-invalidation --distribution-id EXXXXXXXXXXXXX --paths "/*"
```
Replace `EXXXXXXXXXXXXX` with your actual distribution ID.

To find your distribution ID:
- Check Terraform outputs after `terraform apply`
- Or go to AWS Console → CloudFront → Distributions

---

## Tear Down Infrastructure
Only run this if you want to completely remove everything from AWS.

```cmd
cd c:\Users\jacki\Documents\GitHub\My-Professional-Web-Site\infrastructure\terraform
terraform destroy
```
Type `yes` when prompted. This will delete the S3 bucket, CloudFront distribution, ACM certificate, and Route 53 records.

> ⚠️ Empty the S3 bucket before running destroy or it will fail:
> ```cmd
> aws s3 rm s3://databyschroeder.com --recursive
> ```
