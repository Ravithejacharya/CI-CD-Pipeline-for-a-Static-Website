# Development Guide

## Getting Started

### Setup Your Development Environment

```bash
# Clone the repository
git clone https://github.com/your-org/static-website-cicd.git
cd static-website-cicd

# Install dependencies
npm install

# Start development server
npm run dev
```

The site will be available at `http://localhost:3000`

## Project Structure

```
.
├── .github/workflows/
│   └── deploy.yml                    # CI/CD pipeline configuration
├── config/
│   ├── aws.example.json             # AWS configuration template
│   ├── cloudformation-template.yaml # AWS infrastructure template
│   └── github-oidc-template.yaml    # GitHub OIDC configuration
├── public/                          # Static assets (images, etc.)
├── scripts/
│   ├── build.js                    # Build script
│   └── setup-aws.sh                # AWS setup script
├── src/
│   ├── index.html                  # Main HTML file
│   ├── styles.css                  # Global styles
│   ├── script.js                   # Main JavaScript
│   └── __tests__/
│       └── index.test.js           # Jest tests
├── .eslintrc.json                  # ESLint configuration
├── jest.config.js                  # Jest test configuration
├── jest.setup.js                   # Jest setup file
├── jest.setup.js                   # Test environment setup
├── package.json                    # Dependencies and scripts
├── Dockerfile                      # Docker container config
├── docker-compose.yml              # Docker Compose config
├── Makefile                        # Make tasks
├── README.md                       # Project overview
├── DEPLOYMENT.md                   # Deployment guide
└── CONTRIBUTING.md                 # Contributing guidelines
```

## Development Workflow

### 1. Creating Features

```bash
# Create a feature branch
git checkout -b feature/my-feature

# Make changes to src/ files
# Edit src/index.html, src/styles.css, src/script.js

# Test your changes
npm run dev
```

### 2. Testing

```bash
# Run all tests
npm test

# Run tests in watch mode (auto-rerun on file changes)
npm test -- --watch

# Run tests with coverage report
npm run test:coverage

# Run specific test file
npm test -- index.test.js
```

### 3. Linting

```bash
# Check code style
npm run lint

# Fix linting errors automatically
npx eslint src/ --fix
```

### 4. Building

```bash
# Build for production
npm run build

# Output will be in ./dist/ directory
```

### 5. Committing Changes

```bash
# Stage changes
git add .

# Commit with descriptive message
git commit -m "feat: add new feature description"

# Push to your branch
git push origin feature/my-feature

# Create Pull Request on GitHub
```

## Code Style Guidelines

### JavaScript
- Use `const` and `let` (no `var`)
- Use arrow functions where appropriate
- Use strict equality (`===` not `==`)
- Add semicolons at end of statements
- Use camelCase for variables and functions
- Use PascalCase for classes

### HTML
- Use semantic HTML5 elements
- Add alt text for images
- Use proper heading hierarchy (h1 → h2 → h3)
- Keep HTML clean and readable

### CSS
- Use BEM naming convention (Block__Element--Modifier)
- Group related properties
- Use CSS custom properties for colors/sizes
- Mobile-first responsive design

### Example:
```javascript
// ✓ Good
const calculateTotal = (items) => {
  return items.reduce((sum, item) => sum + item.price, 0);
};

// ✗ Bad
var calculateTotal = function(items) {
  var sum = 0;
  for (var i = 0; i < items.length; i++) {
    sum = sum + items[i].price;
  }
  return sum;
}
```

## Testing Guidelines

### Writing Tests

```javascript
describe('Feature Name', () => {
  beforeEach(() => {
    // Setup before each test
    document.body.innerHTML = `<div id="app"></div>`;
  });

  test('should do something', () => {
    // Arrange
    const element = document.getElementById('app');
    
    // Act
    element.textContent = 'Hello';
    
    // Assert
    expect(element.textContent).toBe('Hello');
  });

  test('should handle edge cases', () => {
    // Test edge cases and error conditions
    expect(() => {
      functionThatThrows();
    }).toThrow();
  });
});
```

### Test Coverage Thresholds
- Statements: 70%
- Branches: 70%
- Functions: 70%
- Lines: 70%

Increase coverage as needed for critical features.

## Docker Development

### Build Docker Image

```bash
# Build image
npm run docker:build

# Build with specific tag
docker build -t my-site:1.0.0 .
```

### Run Docker Container

```bash
# Run container
npm run docker:run

# Run with custom port
docker run -p 8080:3000 static-website:latest

# Run with environment variables
docker run -e NODE_ENV=production static-website:latest
```

### Using Docker Compose

```bash
# Start services
npm run docker:compose

# Run in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

## Common Tasks

### Update Dependencies

```bash
# Check for outdated packages
npm outdated

# Update package.json
npm update

# Update specific package
npm install package-name@latest
```

### Add New Dependencies

```bash
# Add production dependency
npm install package-name

# Add development dependency
npm install --save-dev package-name

# After changes, commit package-lock.json
```

### Debug Issues

```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install

# Clear npm cache
npm cache clean --force

# Check npm version
npm --version
node --version
```

## Git Workflow

### Branch Naming Conventions

```
feature/description        # New feature
bugfix/description        # Bug fix
hotfix/description        # Urgent production fix
docs/description          # Documentation update
refactor/description      # Code refactoring
test/description          # Test updates
```

### Commit Message Format

```
<type>: <subject>

<body>

<footer>
```

**Types:**
- feat: new feature
- fix: bug fix
- docs: documentation
- style: formatting
- refactor: code restructuring
- test: test updates
- ci: CI/CD changes
- chore: maintenance

**Example:**
```
feat: add dark mode toggle

- Implements dark mode switch in navbar
- Adds CSS custom properties for theme colors
- Stores preference in localStorage

Closes #123
```

## Performance Tips

1. **Minimize CSS/JS files** in production build
2. **Optimize images** before committing
3. **Lazy load** images and scripts
4. **Cache busting** for updated assets
5. **Minify** HTML in production
6. **Tree shake** unused code

## Troubleshooting

### npm install fails
```bash
# Clear cache
npm cache clean --force

# Remove node_modules
rm -rf node_modules

# Reinstall
npm install
```

### Tests failing
```bash
# Run tests with verbose output
npm test -- --verbose

# Run single test
npm test -- index.test.js -t "test name"

# Update snapshots (if using)
npm test -- --updateSnapshot
```

### Build fails
```bash
# Check for syntax errors
npm run lint

# Try build again
npm run build

# Check dist/ directory created
ls -la dist/
```

### Docker issues
```bash
# Remove all containers
docker rm $(docker ps -a -q)

# Remove all images
docker rmi $(docker images -q)

# Start fresh
npm run docker:build
npm run docker:run
```

## Useful Resources

- [MDN Web Docs](https://developer.mozilla.org/)
- [JavaScript.info](https://javascript.info/)
- [Web.dev](https://web.dev/)
- [CSS Tricks](https://css-tricks.com/)
- [Jest Documentation](https://jestjs.io/)
- [ESLint Rules](https://eslint.org/docs/rules/)

## Getting Help

1. Check the [README.md](./README.md)
2. Review [CONTRIBUTING.md](./CONTRIBUTING.md)
3. Check existing issues on GitHub
4. Open a new issue with detailed description
5. Contact project maintainers

## Setting Up IDE

### VS Code Extensions (Recommended)
- ESLint
- Prettier - Code formatter
- Jest
- GitLens
- Live Server
- Docker

### VS Code Settings
```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "eslint.validate": ["javascript"],
  "jest.autoRun": "off"
}
```

## Environment Variables

Create `.env.local` for local development (not committed):

```bash
# Example .env.local
NODE_ENV=development
DEBUG=true
API_URL=http://localhost:3000
```

## Pre-commit Hooks (Optional)

Install husky for automated checks:

```bash
npm install husky --save-dev
npx husky install

# Add pre-commit hook
echo "npm test && npm run lint" > .husky/pre-commit
```

This ensures tests and linting pass before committing.
