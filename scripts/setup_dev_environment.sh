#!/bin/bash

# Complete Development Environment Setup Script
# Sets up all development tools and configurations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Function to print step
print_step() {
    echo -e "\n${BLUE}🔧 $1${NC}"
    echo "----------------------------------------"
}

# Function to print success
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Function to print error
print_error() {
    echo -e "${RED}❌ $1${NC}"
}

echo -e "${PURPLE}🚀 Flutter DDD Template - Development Environment Setup${NC}"
echo "======================================================="
echo ""

# 1. Check prerequisites
print_step "Checking prerequisites"

if ! command -v git &> /dev/null; then
    print_error "Git is not installed"
    exit 1
fi
print_success "Git found"

if command -v fvm &> /dev/null; then
    print_success "FVM found: $(fvm --version)"
    FLUTTER_CMD="fvm flutter"
    DART_CMD="fvm dart"
elif command -v flutter &> /dev/null; then
    print_warning "Using system Flutter: $(flutter --version | head -1)"
    FLUTTER_CMD="flutter"
    DART_CMD="dart"
else
    print_error "Flutter not found. Please install Flutter or FVM"
    exit 1
fi

# 2. Setup FVM (if available)
if command -v fvm &> /dev/null; then
    print_step "Setting up FVM"
    if [ ! -f ".fvmrc" ]; then
        fvm use stable
        print_success "FVM configured with stable Flutter"
    else
        print_success "FVM already configured: $(cat .fvmrc)"
    fi
fi

# 3. Install dependencies
print_step "Installing Flutter dependencies"
$FLUTTER_CMD packages get
print_success "Dependencies installed"

# 4. Setup pre-commit hooks
print_step "Setting up pre-commit hooks"
if command -v pre-commit &> /dev/null; then
    pre-commit install
    pre-commit install --hook-type commit-msg
    print_success "Pre-commit hooks installed"
else
    print_warning "pre-commit not found. Installing..."
    if command -v pip3 &> /dev/null; then
        pip3 install pre-commit
        pre-commit install
        pre-commit install --hook-type commit-msg
        print_success "Pre-commit installed and configured"
    elif command -v brew &> /dev/null; then
        brew install pre-commit
        pre-commit install
        pre-commit install --hook-type commit-msg
        print_success "Pre-commit installed and configured"
    else
        print_error "Could not install pre-commit. Please install manually"
    fi
fi

# 5. Run build_runner
print_step "Running build_runner"
if find lib -name "*.dart" -exec grep -l "@freezed\|@injectable\|@JsonSerializable" {} \; | head -1 > /dev/null; then
    $FLUTTER_CMD packages pub run build_runner build --delete-conflicting-outputs
    print_success "Build runner completed"
else
    print_warning "No generated code found, skipping build_runner"
fi

# 6. Run linting and formatting
print_step "Running code quality checks"
$DART_CMD format .
print_success "Code formatted"

$DART_CMD analyze .
print_success "Code analyzed"

# 7. Run tests
print_step "Running tests"
$FLUTTER_CMD test
print_success "Tests passed"

# 8. Setup VS Code settings
print_step "Configuring VS Code"
if [ -f ".vscode/settings.json" ]; then
    print_success "VS Code settings already configured"
else
    print_warning "VS Code settings not found, but will be created by FVM"
fi

# 9. Create development shortcuts
print_step "Creating development shortcuts"

# Create aliases file
cat > .dev_aliases << 'EOF'
# Flutter DDD Template Development Aliases
alias fdev="fvm flutter run --target=lib/main_development.dart"
alias fstaging="fvm flutter run --target=lib/main_staging.dart"
alias fprod="fvm flutter run --target=lib/main_production.dart"
alias ftest="fvm flutter test"
alias fformat="fvm dart format ."
alias fanalyze="fvm dart analyze ."
alias fbuild="fvm flutter packages pub run build_runner build --delete-conflicting-outputs"
alias fclean="fvm flutter clean && fvm flutter packages get"
alias fquality="./scripts/dev_quality.sh"
alias fcheck="pre-commit run --all-files"
EOF

print_success "Development aliases created (.dev_aliases)"

# 10. Environment validation
print_step "Validating development environment"

# Check if all required tools are available
VALIDATION_PASSED=true

if ! $FLUTTER_CMD doctor > /dev/null 2>&1; then
    print_error "Flutter doctor found issues"
    VALIDATION_PASSED=false
else
    print_success "Flutter doctor passed"
fi

if ! $DART_CMD analyze . > /dev/null 2>&1; then
    print_error "Code analysis found issues"
    VALIDATION_PASSED=false
else
    print_success "Code analysis passed"
fi

if ! $FLUTTER_CMD test > /dev/null 2>&1; then
    print_error "Tests failed"
    VALIDATION_PASSED=false
else
    print_success "Tests passed"
fi

# 11. Summary and next steps
echo ""
echo -e "${PURPLE}📋 Development Environment Setup Summary${NC}"
echo "========================================"

if [ "$VALIDATION_PASSED" = true ]; then
    print_success "All validations passed! 🎉"
else
    print_warning "Some validations failed. Please check the output above."
fi

echo ""
echo -e "${BLUE}📚 Available Development Scripts:${NC}"
echo "  ./scripts/dev_quality.sh         - Run comprehensive quality checks"
echo "  ./scripts/build_flavors.sh       - Build app for different flavors"
echo "  ./scripts/setup_pre_commit.sh    - Setup/update pre-commit hooks"
echo ""

echo -e "${BLUE}🔧 Development Commands:${NC}"
echo "  Source aliases: source .dev_aliases"
echo "  Development:    fdev"
echo "  Staging:        fstaging" 
echo "  Production:     fprod"
echo "  Run tests:      ftest"
echo "  Format code:    fformat"
echo "  Analyze code:   fanalyze"
echo "  Build runner:   fbuild"
echo "  Quality check:  fquality"
echo "  Pre-commit:     fcheck"
echo ""

echo -e "${BLUE}🎯 Next Steps:${NC}"
echo "1. Source the aliases: source .dev_aliases"
echo "2. Start development: fdev"
echo "3. Make changes and commit (pre-commit hooks will run automatically)"
echo "4. Use the debug panel in development mode"
echo "5. Run quality checks before pushing: fquality"
echo ""

echo -e "${GREEN}🎉 Development environment setup complete!${NC}"
echo "Happy coding! 🚀"