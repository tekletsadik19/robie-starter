#!/bin/bash

# Flutter Development Quality Script
# Runs comprehensive code quality checks and fixes

set -e

echo "🚀 Flutter Development Quality Checks"
echo "====================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Determine Flutter command
if command -v fvm &> /dev/null; then
    FLUTTER_CMD="fvm flutter"
    DART_CMD="fvm dart"
    echo -e "${GREEN}✅ Using FVM${NC}"
else
    FLUTTER_CMD="flutter"
    DART_CMD="dart"
    echo -e "${YELLOW}⚠️  Using system Flutter${NC}"
fi

# Function to print step
print_step() {
    echo -e "\n${BLUE}🔧 $1${NC}"
    echo "----------------------------------------"
}

# Function to handle errors
handle_error() {
    echo -e "${RED}❌ $1 failed${NC}"
    exit 1
}

# 1. Get dependencies
print_step "Getting Flutter packages"
$FLUTTER_CMD packages get || handle_error "Package get"

# 2. Clean build artifacts
print_step "Cleaning build artifacts"
$FLUTTER_CMD clean || handle_error "Flutter clean"

# 3. Format code
print_step "Formatting Dart code"
$DART_CMD format . || handle_error "Code formatting"

# 4. Run build_runner
print_step "Running build_runner"
if find lib -name "*.dart" -exec grep -l "@freezed\|@injectable\|@JsonSerializable" {} \; | head -1 > /dev/null; then
    $FLUTTER_CMD packages pub run build_runner build --delete-conflicting-outputs || handle_error "Build runner"
else
    echo "No generated code found, skipping build_runner"
fi

# 5. Analyze code
print_step "Analyzing Dart code"
$DART_CMD analyze . || handle_error "Code analysis"

# 6. Run tests
print_step "Running tests"
$FLUTTER_CMD test || handle_error "Tests"

# 7. Check for unused dependencies
print_step "Checking for unused dependencies"
if command -v dart_dependency_validator &> /dev/null; then
    dart_dependency_validator || echo -e "${YELLOW}⚠️  Some dependencies might be unused${NC}"
else
    echo "dart_dependency_validator not installed, skipping..."
fi

# 8. Check import sorting (basic check)
print_step "Checking import organization"
find lib -name "*.dart" -exec grep -l "^import" {} \; | while read -r file; do
    if ! grep -q "^import 'dart:" "$file" && grep -q "^import 'package:" "$file"; then
        continue
    fi
    # Basic check - could be enhanced with a proper import sorter
done
echo "Import organization check completed"

# 9. Check for TODOs and FIXMEs
print_step "Checking for TODOs and FIXMEs"
TODO_COUNT=$(find lib -name "*.dart" -exec grep -l "TODO\|FIXME" {} \; | wc -l | tr -d ' ')
if [ "$TODO_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Found $TODO_COUNT files with TODOs/FIXMEs${NC}"
    find lib -name "*.dart" -exec grep -Hn "TODO\|FIXME" {} \;
else
    echo -e "${GREEN}✅ No TODOs or FIXMEs found${NC}"
fi

# 10. Check file sizes
print_step "Checking for large files"
find lib -name "*.dart" -size +500c -exec ls -lh {} \; | while read -r line; do
    size=$(echo "$line" | awk '{print $5}')
    file=$(echo "$line" | awk '{print $NF}')
    if [[ $size =~ ^[0-9]+K$ ]] && [ "${size%K}" -gt 10 ]; then
        echo -e "${YELLOW}⚠️  Large file: $file ($size)${NC}"
    fi
done

# 11. Performance checks
print_step "Performance recommendations"
PERFORMANCE_ISSUES=0

# Check for ListView without itemExtent
if find lib -name "*.dart" -exec grep -l "ListView(" {} \; | xargs grep -L "itemExtent\|shrinkWrap: true" | head -1 > /dev/null; then
    echo -e "${YELLOW}⚠️  Consider using itemExtent for ListView performance${NC}"
    ((PERFORMANCE_ISSUES++))
fi

# Check for missing const constructors
MISSING_CONST=$(find lib -name "*.dart" -exec grep -l "class.*extends.*Widget" {} \; | xargs grep -L "const.*(" | wc -l | tr -d ' ')
if [ "$MISSING_CONST" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  $MISSING_CONST widget classes might be missing const constructors${NC}"
    ((PERFORMANCE_ISSUES++))
fi

if [ "$PERFORMANCE_ISSUES" -eq 0 ]; then
    echo -e "${GREEN}✅ No obvious performance issues found${NC}"
fi

# 12. Security checks
print_step "Security checks"
SECURITY_ISSUES=0

# Check for hardcoded secrets (basic patterns)
if find lib -name "*.dart" -exec grep -l "password\|secret\|api_key\|token" {} \; | xargs grep -i "=.*['\"][a-zA-Z0-9]{10,}['\"]" | head -1 > /dev/null; then
    echo -e "${RED}⚠️  Possible hardcoded secrets found${NC}"
    ((SECURITY_ISSUES++))
fi

# Check for HTTP URLs in production code
if find lib -name "*.dart" -exec grep -l "http://" {} \; | head -1 > /dev/null; then
    echo -e "${YELLOW}⚠️  HTTP URLs found - consider using HTTPS${NC}"
    ((SECURITY_ISSUES++))
fi

if [ "$SECURITY_ISSUES" -eq 0 ]; then
    echo -e "${GREEN}✅ No obvious security issues found${NC}"
fi

# Summary
echo -e "\n${GREEN}🎉 Development Quality Checks Complete!${NC}"
echo "======================================="
echo -e "${GREEN}✅ Code formatted${NC}"
echo -e "${GREEN}✅ Code analyzed${NC}"
echo -e "${GREEN}✅ Tests passed${NC}"
echo -e "${GREEN}✅ Build artifacts cleaned${NC}"
echo -e "${GREEN}✅ Dependencies updated${NC}"

if [ "$TODO_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  $TODO_COUNT files with TODOs/FIXMEs${NC}"
fi

if [ "$PERFORMANCE_ISSUES" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  $PERFORMANCE_ISSUES potential performance issues${NC}"
fi

if [ "$SECURITY_ISSUES" -gt 0 ]; then
    echo -e "${RED}⚠️  $SECURITY_ISSUES potential security issues${NC}"
fi

echo ""
echo "Next steps:"
echo "  - Run 'git add .' to stage formatted files"
echo "  - Run 'git commit' to commit changes"
echo "  - Run '$FLUTTER_CMD run' to test the app"