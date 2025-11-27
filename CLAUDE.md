# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a **template repository** for setting up testing infrastructure in Next.js/React projects. It is not a standalone application—it provides configuration files that get copied to target projects.

## Commands

```bash
# Apply template to a target project
./setup.sh /path/to/target/project

# Run tests (in target project after setup)
pnpm test        # Watch mode
pnpm test:run    # Single run (used by CI)
```

## What Gets Copied

The `setup.sh` script copies these files to target projects:
- `.github/workflows/test.yml` - GitHub Actions workflow
- `vitest.config.ts` - Vitest configuration for React/Next.js
- `vitest.setup.ts` - Test setup with jest-dom matchers and matchMedia mock

## Test Configuration

- **Environment**: jsdom
- **Globals**: enabled (no imports needed for `describe`, `it`, `expect`)
- **Path alias**: `@` resolves to project root
- **Test pattern**: `**/*.{test,spec}.{js,ts,jsx,tsx}`
