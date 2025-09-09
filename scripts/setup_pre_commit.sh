#!/bin/bash

echo "🚀 Setting up pre-commit hooks for Flutter DDD Template"
echo "======================================================="

# Check if pre-commit is installed
if ! command -v pre-commit &> /dev/null; then
    echo "❌ pre-commit not found. Installing..."
    
    # Try different installation methods
    if command -v pip3 &> /dev/null; then
        pip3 install pre-commit
    elif command -v pip &> /dev/null; then
        pip install pre-commit
    elif command -v brew &> /dev/null; then
        brew install pre-commit
    else
        echo "❌ Could not install pre-commit. Please install manually:"
        echo "   pip install pre-commit"
        echo "   or"
        echo "   brew install pre-commit"
        exit 1
    fi
fi

echo "✅ pre-commit found: $(pre-commit --version)"

# Install the git hooks
echo "📦 Installing pre-commit hooks..."
pre-commit install

# Install commit-msg hook for conventional commits
echo "📝 Installing commit-msg hook..."
pre-commit install --hook-type commit-msg

# Run hooks on all files to test
echo "🧪 Running pre-commit on all files to test setup..."
pre-commit run --all-files

echo ""
echo "✅ Pre-commit hooks setup complete!"
echo ""
echo "Next steps:"
echo "  1. Hooks will now run automatically on git commit"
echo "  2. To run manually: pre-commit run --all-files"
echo "  3. To update hooks: pre-commit autoupdate"
echo "  4. To skip hooks: git commit --no-verify"
echo ""
echo "Available hooks:"
echo "  - dart-format: Formats Dart code"
echo "  - dart-analyze: Analyzes Dart code for issues"
echo "  - flutter-test: Runs tests (on push only)"
echo "  - flutter-build-runner: Runs build_runner when needed"
echo "  - pubspec-lock-check: Updates pubspec.lock when needed"
echo "  - import-sorter: Sorts Dart imports"
echo "  - trailing-whitespace: Removes trailing whitespace"
echo "  - end-of-file-fixer: Ensures files end with newline"
echo "  - check-yaml: Validates YAML syntax"
echo "  - check-json: Validates JSON syntax"
echo "  - check-merge-conflict: Prevents committing merge conflicts"