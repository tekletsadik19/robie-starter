#!/bin/bash

# Script to delete all branches except main
# This script will delete both local and remote branches

set -e  # Exit on any error

echo "🧹 Cleaning up branches (keeping main branch only)..."

# Get current branch
current_branch=$(git branch --show-current)
echo "Current branch: $current_branch"

# Switch to main if not already on main
if [ "$current_branch" != "main" ]; then
    echo "Switching to main branch..."
    git checkout main
fi

# Delete local branches (except main)
echo "Deleting local branches..."
local_branches=$(git branch | grep -v "main" | grep -v "^\*" | sed 's/^[[:space:]]*//' || true)

if [ -n "$local_branches" ]; then
    echo "Local branches to delete:"
    echo "$local_branches"
    echo "$local_branches" | xargs -r git branch -D
    echo "✅ Local branches deleted"
else
    echo "No local branches to delete"
fi

# Delete remote branches (except main)
echo "Deleting remote branches..."
remote_branches=$(git branch -r | grep -v "origin/main" | grep -v "HEAD" | sed 's/origin\///' | sed 's/^[[:space:]]*//' || true)

if [ -n "$remote_branches" ]; then
    echo "Remote branches to delete:"
    echo "$remote_branches"
    echo "$remote_branches" | xargs -r -I {} git push origin --delete {}
    echo "✅ Remote branches deleted"
else
    echo "No remote branches to delete"
fi

# Clean up remote tracking branches
echo "Cleaning up remote tracking branches..."
git remote prune origin

echo "🎉 Branch cleanup completed!"
echo "Remaining branches:"
git branch -a
