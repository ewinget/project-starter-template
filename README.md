# Project Starter Template

[![Tests](https://github.com/ewinget/project-starter-template/actions/workflows/test.yml/badge.svg)](https://github.com/ewinget/project-starter-template/actions/workflows/test.yml)

Automated testing infrastructure for Next.js/React projects with GitHub Actions and CodeRabbit integration.

## Quick Start

```bash
~/Documents/project-starter-template/setup.sh /path/to/your/project
```

That's it. The script handles everything.

## What It Does

1. Copies test configuration files to your project
2. Installs all required dev dependencies
3. Sets up GitHub Actions to run tests on every PR

## What's Included

```
project-starter-template/
├── .github/
│   └── workflows/
│       └── test.yml        # Runs tests on PRs and pushes to main
├── vitest.config.ts        # Vitest config for React/Next.js
├── vitest.setup.ts         # Test setup with jest-dom matchers
├── setup.sh                # One-command setup script
├── README.md               # This file
└── CHECKLIST.md            # Quick reference checklist
```

## Requirements

- pnpm (the script uses pnpm to install dependencies)
- Node.js 20+
- An existing Next.js or React project

## After Running Setup

1. **Add test scripts to package.json** (if not already present):
   ```json
   {
     "scripts": {
       "test": "vitest",
       "test:run": "vitest run"
     }
   }
   ```

2. **Install CodeRabbit on your repo** (one-time):
   - Go to https://github.com/apps/coderabbitai
   - Click "Install"
   - Select your repository

3. **Commit and push**:
   ```bash
   git add .
   git commit -m "Add testing infrastructure"
   git push
   ```

## Writing Tests

Create test files next to your components:

```
components/
  Button.tsx
  Button.test.tsx    # Test file
```

Example test:

```tsx
import { render, screen } from '@testing-library/react'
import { Button } from './Button'

describe('Button', () => {
  it('renders children', () => {
    render(<Button>Click me</Button>)
    expect(screen.getByText('Click me')).toBeInTheDocument()
  })
})
```

## How the Workflow Works

1. You push code and open/update a PR
2. CodeRabbit automatically reviews the PR and may suggest unit tests
3. GitHub Actions runs your test suite
4. Results appear as checks on the PR
5. You merge when everything passes

## Safety

The script checks for existing files before overwriting:
- `vitest.config.ts`
- `vitest.setup.ts`
- `.github/workflows/test.yml`

If any exist, it will prompt you to confirm before proceeding.
