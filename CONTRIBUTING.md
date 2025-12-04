# Contributing Guide

## Development Setup

1. Clone the repository
2. Install dependencies: `npm install`
3. Create a feature branch: `git checkout -b feature/your-feature`
4. Make changes and test locally
5. Push to your fork
6. Create a Pull Request

## Code Standards

### JavaScript
- Use ESLint: `npm run lint`
- Format code: Use Prettier (`npm run format` if available)
- Write tests for new features

### Testing
- Run tests: `npm test`
- Maintain coverage above 70%
- Test both happy paths and edge cases

### Commits
- Use clear, descriptive commit messages
- Reference issues when applicable
- Follow conventional commits format:
  - `feat:` for new features
  - `fix:` for bug fixes
  - `docs:` for documentation
  - `chore:` for maintenance

## Pull Request Process

1. Update README.md with new features
2. Ensure all tests pass
3. Verify linting passes
4. Add security scan results
5. Request review from maintainers

## Security

- Never commit secrets or credentials
- Report security issues to security@example.com
- Use environment variables for sensitive data
- Follow AWS security best practices

## Questions?

Open an issue or contact the team lead.
