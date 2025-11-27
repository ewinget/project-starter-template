#!/bin/bash

# Setup testing infrastructure for a new project
# Usage: ./setup.sh /path/to/your/project

set -e

TARGET_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Check arguments
if [ -z "$TARGET_DIR" ]; then
  echo "Usage: ./setup.sh /path/to/your/project"
  exit 1
fi

# Expand tilde if present
TARGET_DIR="${TARGET_DIR/#\~/$HOME}"

# Validate target directory
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory '$TARGET_DIR' does not exist"
  exit 1
fi

# Check for package.json
if [ ! -f "$TARGET_DIR/package.json" ]; then
  echo "Error: No package.json found in '$TARGET_DIR'"
  echo "This script is intended for existing Node.js projects."
  exit 1
fi

# Check for pnpm
if ! command -v pnpm &> /dev/null; then
  echo "Error: pnpm is not installed"
  echo "Install it with: npm install -g pnpm"
  exit 1
fi

echo "Setting up testing infrastructure in: $TARGET_DIR"
echo ""

# Check for existing files
CONFLICTS=()

if [ -f "$TARGET_DIR/vitest.config.ts" ]; then
  CONFLICTS+=("vitest.config.ts")
fi

if [ -f "$TARGET_DIR/vitest.setup.ts" ]; then
  CONFLICTS+=("vitest.setup.ts")
fi

if [ -f "$TARGET_DIR/.github/workflows/test.yml" ]; then
  CONFLICTS+=(".github/workflows/test.yml")
fi

# Warn about conflicts
if [ ${#CONFLICTS[@]} -gt 0 ]; then
  echo "⚠ The following files already exist and will be overwritten:"
  for file in "${CONFLICTS[@]}"; do
    echo "  - $file"
  done
  echo ""
  read -p "Continue? (y/n) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
  fi
  echo ""
fi

# Copy files
mkdir -p "$TARGET_DIR/.github/workflows"
cp "$SCRIPT_DIR/.github/workflows/test.yml" "$TARGET_DIR/.github/workflows/"
cp "$SCRIPT_DIR/vitest.config.ts" "$TARGET_DIR/"
cp "$SCRIPT_DIR/vitest.setup.ts" "$TARGET_DIR/"

echo "✓ Copied .github/workflows/test.yml"
echo "✓ Copied vitest.config.ts"
echo "✓ Copied vitest.setup.ts"

# Install dependencies
echo ""
echo "Installing dev dependencies..."
cd "$TARGET_DIR"
pnpm add -D vitest @vitejs/plugin-react jsdom @testing-library/react @testing-library/jest-dom @testing-library/user-event

# Check if package.json has test scripts
if grep -q '"test"' package.json; then
  echo ""
  echo "⚠ 'test' script already exists in package.json - verify it's correct"
else
  echo ""
  echo "Add these scripts to your package.json:"
  echo '  "test": "vitest",'
  echo '  "test:run": "vitest run"'
fi

echo ""
echo "✓ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Add test scripts to package.json (if not already present)"
echo "2. Verify CodeRabbit is installed: https://github.com/apps/coderabbitai"
echo "3. Commit and push"
