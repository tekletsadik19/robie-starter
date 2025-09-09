#!/bin/bash

# Script to clear all git history and reinitialize as fresh repository
# WARNING: This will permanently delete all commit history!

set -e  # Exit on any error

echo "⚠️  WARNING: This will permanently delete ALL git history!"
echo "Current repository will be reinitialized as a fresh start."
echo ""

# Get the remote URL before we delete everything
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
echo "Remote URL: $REMOTE_URL"

# Confirm before proceeding
read -p "Are you sure you want to proceed? Type 'YES' to continue: " confirmation
if [ "$confirmation" != "YES" ]; then
    echo "❌ Operation cancelled."
    exit 1
fi

echo "🧹 Clearing git history..."

# Remove the .git directory to delete all history
rm -rf .git

# Initialize a new git repository
echo "🔄 Initializing new git repository..."
git init

# Add all files to the new repository
echo "📁 Adding all files..."
git add .

# Create the initial commit
echo "💾 Creating initial commit..."
git commit -m "Initial commit: Flutter DDD Starter Project

- Complete Flutter project with Domain-Driven Design architecture
- Multi-environment configuration (development, staging, production)
- Security features and device integrity checks
- Clean architecture with proper separation of concerns
- Comprehensive testing setup
- CI/CD ready with proper build configurations"

# Add the remote origin back
if [ -n "$REMOTE_URL" ]; then
    echo "🔗 Adding remote origin..."
    git remote add origin "$REMOTE_URL"
    
    # Force push to replace the remote history
    echo "🚀 Force pushing clean history to remote..."
    git push -f origin main
    echo "✅ Successfully pushed clean history to remote!"
else
    echo "⚠️  No remote URL found. You'll need to add a remote manually:"
    echo "   git remote add origin <your-repo-url>"
    echo "   git push -u origin main"
fi

echo ""
echo "🎉 Git history has been completely reset!"
echo "📊 Repository status:"
git log --oneline
echo ""
echo "📁 Current branch: $(git branch --show-current)"
echo "🔗 Remote: $(git remote -v 2>/dev/null || echo 'No remote configured')"
