# Deployment Setup Guide

## Quick Start

### Prerequisites
- Node.js 18+
- Docker (optional, for containerization)
- AWS CLI configured with credentials
- GitHub account with repository access

### 1. Local Development

```bash
# Install dependencies
npm install

# Build the project
npm run build

# Run development server
npm run dev

# Run tests
npm test

# Run linter
npm run lint
```

### 2. Docker Setup

```bash
# Build Docker image
npm run docker:build

# Run container locally
npm run docker:run

# Use docker-compose
npm run docker:compose

# Access at http://localhost:3000
```

### 3. AWS Infrastructure Setup

#### Option A: Using the Setup Script

```bash
# Make the script executable
chmod +x scripts/setup-aws.sh

# Run the setup script
bash scripts/setup-aws.sh

# Follow the prompts to:
# 1. Enter S3 bucket name
# 2. Enter GitHub repository (owner/repo)
# 3. Enter domain name (optional)
```

#### Option B: Manual Setup with AWS CloudFormation

```bash
# Create S3 bucket and CloudFront distribution
aws cloudformation create-stack \
  --stack-name static-website-stack \
  --template-body file://config/cloudformation-template.yaml \
  --parameters \
    ParameterKey=BucketName,ParameterValue=your-bucket-name \
    ParameterKey=DomainName,ParameterValue=your-domain.com

# Create GitHub OIDC provider and IAM role
aws cloudformation create-stack \
  --stack-name github-oidc-stack \
  --template-body file://config/github-oidc-template.yaml \
  --capabilities CAPABILITY_NAMED_IAM
```

### 4. GitHub Secrets Configuration

Add these secrets to your GitHub repository:
**Settings → Secrets and Variables → Actions**

```
AWS_S3_BUCKET = your-bucket-name
AWS_CLOUDFRONT_DISTRIBUTION_ID = your-distribution-id
AWS_ROLE_TO_ASSUME = arn:aws:iam::ACCOUNT_ID:role/github-actions-deployment-role
```

### 5. Deploy

```bash
# Push to main branch to trigger deployment
git push origin main

# Monitor the workflow
# Go to: GitHub → Actions → Latest Workflow Run
```

## Deployment Architecture

```
Git Push to main
    ↓
GitHub Actions Triggered
    ├── Build & Test
    ├── Security Scan (Trivy)
    ├── Docker Build & Push
    └── Deploy to AWS
        ├── S3 Upload
        └── CloudFront Invalidation
    ↓
Live on https://your-bucket.s3.amazonaws.com
```

## Troubleshooting

### "Access Denied" during deployment
- Verify AWS_ROLE_TO_ASSUME secret is correct
- Check IAM role permissions
- Ensure OIDC provider is configured

### CloudFront not updating
- Check CloudFront distribution ID in secrets
- Verify S3 bucket name
- Wait 2-3 minutes for cache invalidation

### Docker build fails
- Clear Docker cache: `docker system prune`
- Check Node version: `node --version`
- Verify all source files exist

### Tests failing in CI
- Run locally first: `npm test`
- Check coverage thresholds in jest.config.js
- Verify all dependencies installed

## CI/CD Workflow Stages

### 1. Build & Test
- Installs dependencies
- Runs ESLint
- Executes Jest tests with coverage
- Uploads coverage to Codecov

### 2. Security Scan
- Runs Trivy vulnerability scanner
- Uploads SARIF results to GitHub Security
- Blocks deployment on critical issues

### 3. Docker Build
- Builds multi-stage Docker image
- Pushes to GitHub Container Registry
- Caches layers for faster builds

### 4. Deploy
- Configures AWS credentials via OIDC
- Syncs files to S3
- Sets appropriate cache headers
- Invalidates CloudFront cache

## Best Practices

1. **Always test locally** before pushing
2. **Use feature branches** for development
3. **Require PR reviews** before merging to main
4. **Monitor security scans** regularly
5. **Check deployment logs** after each push
6. **Set up branch protection** on main

## Commands Reference

```bash
# Development
npm install          # Install dependencies
npm run build        # Build project
npm run dev          # Run dev server
npm run lint         # Check code style
npm test             # Run tests

# Docker
npm run docker:build      # Build image
npm run docker:run        # Run container
npm run docker:compose    # Run with docker-compose

# AWS
aws s3 ls                 # List S3 buckets
aws cloudfront list-distributions  # List distributions

# Git
git push origin main      # Trigger deployment
```

## Monitoring & Logs

### GitHub Actions
- Go to repository → Actions tab
- Click on workflow run
- Check job logs

### CloudWatch (AWS)
```bash
# View CloudFront logs
aws logs tail /aws/cloudfront/your-distribution --follow
```

### Application Logs
```bash
# In Docker container
docker logs container-id

# Download S3 access logs
aws s3 sync s3://your-bucket-logs/ ./logs/
```

## Security Considerations

✅ **Implemented:**
- OIDC authentication (no hardcoded AWS keys)
- Non-root Docker user
- S3 bucket encryption
- CloudFront HTTPS enforcement
- Automated vulnerability scanning
- Access logs for S3 and CloudFront

⚠️ **Additional Recommendations:**
- Enable CloudTrail for AWS API logging
- Set up CloudWatch alarms for errors
- Enable versioning on S3 bucket
- Use Secrets Manager for sensitive data
- Enable MFA for AWS accounts
- Set up DDoS protection with AWS Shield

## Performance Optimization

### CloudFront Caching
- Index.html: no-cache (always fetch latest)
- Assets: max-age=31536000 (cache forever)
- Compression: enabled for all content types

### S3 Optimization
- Versioning: enabled for rollback
- Transfer Acceleration: available on demand
- Replication: optional for disaster recovery

## Cost Optimization

- **CloudFront:** PriceClass_100 (cheaper, faster)
- **S3:** Standard storage (change as needed)
- **CloudWatch:** Free tier for small sites

Estimated monthly cost: $0.50 - $5.00 for small static sites

## Further Reading

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [AWS S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [CloudFront Distribution](https://docs.aws.amazon.com/cloudfront/latest/developerguide/distribution-overview.html)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Jest Testing](https://jestjs.io/)
