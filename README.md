# CI/CD Pipeline for Static Website

A complete, production-ready CI/CD pipeline for automated build, test, and deployment of a static website using **GitHub Actions**, **Docker**, and **AWS** (S3 + CloudFront).

## 📋 Project Overview

This project demonstrates modern DevOps practices with:
- ✅ Automated testing and linting
- 🔄 Continuous Integration with GitHub Actions
- 🐳 Docker containerization for consistent deployments
- ☁️ AWS S3 deployment with CloudFront CDN
- 🛡️ Security scanning and vulnerability detection
- 📊 Code coverage reporting
- 🚀 Zero-downtime deployments

## 🏗️ Architecture

```
GitHub Repository
        ↓
GitHub Actions Workflow (on push to main/develop)
  ├── Build & Test (Node.js)
  ├── Security Scan (Trivy)
  ├── Docker Build & Push (GitHub Container Registry)
  └── Deploy to AWS (S3 + CloudFront)
        ↓
AWS S3 (Static Assets)
        ↓
CloudFront (CDN)
        ↓
Global Users
```

## 📁 Project Structure

```
.
├── .github/
│   ├── workflows/
│   │   └── deploy.yml              # Main CI/CD workflow
│   ├── dependabot.yml              # Automated dependency updates
│   └── SECURITY.md                 # Security policy
├── public/                         # Static assets
├── src/
│   ├── index.html                  # Main HTML file
│   ├── styles.css                  # Styling
│   └── script.js                   # JavaScript functionality
├── scripts/
│   └── build.js                    # Build script
├── config/
│   └── aws.example.json            # AWS configuration template
├── Dockerfile                      # Container image definition
├── docker-compose.yml              # Local development compose
├── package.json                    # Node.js dependencies
├── .eslintrc.json                  # ESLint configuration
├── jest.config.js                  # Jest testing configuration
└── README.md                       # This file
```

## 🚀 Getting Started

### Prerequisites

- Node.js 18+
- Docker & Docker Compose
- AWS Account with S3 & CloudFront
- GitHub repository with Actions enabled

### Local Development

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Build the project:**
   ```bash
   npm run build
   ```

3. **Run locally:**
   ```bash
   npm run dev
   ```
   Visit `http://localhost:3000`

4. **Run tests:**
   ```bash
   npm test
   ```

5. **Lint code:**
   ```bash
   npm run lint
   ```

### Docker Development

1. **Build Docker image:**
   ```bash
   npm run docker:build
   ```

2. **Run with Docker:**
   ```bash
   npm run docker:run
   ```

3. **Run with Docker Compose:**
   ```bash
   npm run docker:compose
   ```

## 🔧 CI/CD Pipeline Configuration

### GitHub Actions Workflow

The pipeline (`deploy.yml`) includes:

#### 1. **Build Job**
   - Checkout code
   - Setup Node.js 18
   - Install dependencies
   - Run linting
   - Run tests
   - Build application
   - Upload artifacts

#### 2. **Security Scan Job**
   - Trivy vulnerability scanning
   - SARIF report upload to GitHub Security

#### 3. **Docker Build Job**
   - Build multi-stage Docker image
   - Push to GitHub Container Registry
   - Implement layer caching

#### 4. **Deploy Job** (Main branch only)
   - Download build artifacts
   - Configure AWS credentials (OIDC)
   - Deploy to S3
   - Invalidate CloudFront cache

### Required GitHub Secrets

Configure these in Settings → Secrets and Variables → Actions:

```
AWS_S3_BUCKET              # S3 bucket name
AWS_CLOUDFRONT_DISTRIBUTION_ID  # CloudFront distribution ID
AWS_ROLE_TO_ASSUME         # IAM role ARN for OIDC
```

### AWS Setup

1. **Create S3 Bucket:**
   ```bash
   aws s3 mb s3://your-bucket-name --region us-east-1
   ```

2. **Enable Static Website Hosting:**
   ```bash
   aws s3api put-bucket-website \
     --bucket your-bucket-name \
     --website-configuration file://config/website-config.json
   ```

3. **Create CloudFront Distribution:**
   - Origin: S3 bucket
   - Default root object: `index.html`
   - Error page: `index.html` (for SPA)

4. **Setup OIDC for GitHub Actions:**
   - Create IAM role with S3 and CloudFront permissions
   - Add GitHub OIDC provider
   - Configure trust relationship

## 📝 Scripts

| Script | Purpose |
|--------|---------|
| `npm run dev` | Build and serve locally |
| `npm run build` | Build production bundle |
| `npm run lint` | Run ESLint |
| `npm test` | Run Jest tests |
| `npm run test:coverage` | Generate coverage report |
| `npm run docker:build` | Build Docker image |
| `npm run docker:run` | Run Docker container |
| `npm run docker:compose` | Start with Docker Compose |

## 🛡️ Security Features

### Pipeline Security
- ✅ Trivy vulnerability scanning
- ✅ Dependabot automated updates
- ✅ SARIF report uploads
- ✅ Branch protection rules

### Docker Security
- ✅ Non-root user execution
- ✅ Alpine base image (minimal)
- ✅ Health checks enabled
- ✅ No hardcoded secrets

### AWS Security
- ✅ IAM role-based authentication
- ✅ OIDC tokens (no hardcoded credentials)
- ✅ S3 encryption
- ✅ CloudFront DDoS protection

## 🧪 Testing

### Unit Tests
```bash
npm test
```

### Coverage Report
```bash
npm run test:coverage
```

### Coverage Thresholds
- Branches: 70%
- Functions: 70%
- Lines: 70%
- Statements: 70%

## 📊 Monitoring & Logs

### GitHub Actions
- View logs: Actions tab → Workflow runs
- Check deployments: Deployments tab
- Security: Security → Code scanning results

### AWS CloudWatch
- S3 access logs
- CloudFront distribution metrics
- CloudWatch Insights queries

## 🔄 Deployment Process

1. **Push to main branch**
2. **GitHub Actions triggered**
3. **Automated build & tests**
4. **Security scanning**
5. **Docker image created**
6. **Deploy to S3**
7. **CloudFront cache invalidation**
8. **Live deployment status**

## 🌍 Environment Variables

### Development
Create `.env.local`:
```
NODE_ENV=development
```

### Production
Set in GitHub Secrets (no .env files for production)

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
- [AWS S3 Guide](https://docs.aws.amazon.com/s3/)
- [CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [Trivy Scanner](https://github.com/aquasecurity/trivy)

## 🤝 Contributing

1. Create a feature branch
2. Make changes and test locally
3. Push to develop branch
4. Create pull request
5. Await CI/CD checks
6. Merge to main for deployment

## 📄 License

MIT License - See LICENSE file for details

## 🆘 Troubleshooting

### Deploy fails with "Access Denied"
- Check AWS IAM role permissions
- Verify S3 bucket name in secrets
- Ensure OIDC provider is configured

### CloudFront cache not invalidating
- Check CloudFront distribution ID
- Verify IAM permissions include CloudFront access
- Check CloudFront distribution status

### Docker build fails
- Clear Docker cache: `docker system prune`
- Check Dockerfile syntax
- Verify build context includes required files

### Tests fail locally but pass in CI
- Check Node.js version: `node --version`
- Clear node_modules: `rm -rf node_modules && npm ci`
- Check for environment-specific code

## 📞 Support

For issues or questions:
1. Check GitHub Issues
2. Review documentation
3. Create detailed bug report with logs
4. Contact team lead

---

**Last Updated:** December 2024  
**Version:** 1.0.0
# CI-CD-Pipeline-for-a-Static-Website
