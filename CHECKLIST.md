# New Project Testing Setup Checklist

## Quick Setup (5 minutes)

- [ ] Copy `.github/workflows/test.yml` to new project
- [ ] Copy `vitest.config.ts` to new project  
- [ ] Copy `vitest.setup.ts` to new project
- [ ] Install dependencies:
      ```
      pnpm add -D vitest @vitejs/plugin-react jsdom @testing-library/react @testing-library/jest-dom @testing-library/user-event
      ```
- [ ] Add scripts to package.json:
      ```json
      "test": "vitest",
      "test:run": "vitest run"
      ```
- [ ] Verify CodeRabbit is installed on repo (https://github.com/apps/coderabbitai)
- [ ] Commit and push

## Verification

- [ ] Run `pnpm test:run` locally — should pass (or show no tests found)
- [ ] Push to GitHub and open a PR
- [ ] Confirm GitHub Actions "Tests" workflow runs
- [ ] Confirm CodeRabbit comments on the PR

## One-liner Copy Command

From the template directory:

```bash
cp -r .github vitest.config.ts vitest.setup.ts /path/to/your/new-project/
```
