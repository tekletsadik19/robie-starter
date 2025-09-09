#!/bin/bash

# Script to fix common linting issues
echo "🔧 Fixing common linting issues..."

# Determine Flutter command
if command -v fvm &> /dev/null; then
    DART_CMD="fvm dart"
else
    DART_CMD="dart"
fi

echo "📝 Formatting all Dart files..."
$DART_CMD format .

echo "✅ Dart formatting completed"

# Add newlines to end of files that are missing them
echo "📄 Adding missing newlines to end of files..."

find lib -name "*.dart" -exec sh -c 'if [ "$(tail -c1 "$1")" != "" ]; then echo "" >> "$1"; fi' _ {} \;
find test -name "*.dart" -exec sh -c 'if [ "$(tail -c1 "$1")" != "" ]; then echo "" >> "$1"; fi' _ {} \;

echo "✅ Newlines added to files"

echo "🎉 Lint fixes completed!"
echo "Run 'flutter analyze' to check remaining issues."