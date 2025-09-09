#!/bin/bash

echo "🚀 Setting up FVM for Flutter DDD Starter Project"
echo "================================================"
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew not found. Please install Homebrew first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo "✅ Homebrew found"

# Check if FVM is already installed
if command -v fvm &> /dev/null; then
    echo "✅ FVM is already installed"
    fvm --version
else
    echo "📦 Installing FVM..."
    
    # Add FVM tap
    echo "Adding FVM tap..."
    brew tap leoafarias/fvm
    
    # Install FVM
    echo "Installing FVM..."
    brew install fvm
    
    if command -v fvm &> /dev/null; then
        echo "✅ FVM installed successfully!"
        fvm --version
    else
        echo "❌ FVM installation failed"
        exit 1
    fi
fi

echo ""
echo "🎯 Setting up FVM for this project..."

# List available Flutter versions
echo "Available Flutter versions:"
fvm releases --limit 5

echo ""
echo "📌 Setting up stable Flutter version for project..."

# Install and use stable Flutter version
fvm install stable
fvm use stable

if [ -f ".fvmrc" ]; then
    echo "✅ .fvmrc file created with version: $(cat .fvmrc)"
else
    echo "❌ Failed to create .fvmrc file"
    exit 1
fi

echo ""
echo "⚙️ Configuring VS Code..."

# VS Code settings should already be created
if [ -f ".vscode/settings.json" ]; then
    echo "✅ VS Code settings configured for FVM"
else
    echo "⚠️  VS Code settings not found, but will be created by FVM"
fi

echo ""
echo "📦 Installing Flutter dependencies..."

# Get Flutter packages
fvm flutter packages get

echo ""
echo "🔧 Running build_runner..."

# Run build runner
fvm flutter packages pub run build_runner build --delete-conflicting-outputs

echo ""
echo "🧪 Running tests to verify setup..."

# Run tests
fvm flutter test test/shared/infrastructure/security/hive_migration_test.dart

echo ""
echo "🎉 FVM setup completed successfully!"
echo ""
echo "Next steps:"
echo "  1. Restart VS Code to pick up the new Flutter SDK path"
echo "  2. Use 'fvm flutter' prefix for all Flutter commands"
echo "  3. Run './test_migration.sh' to test your Hive migration"
echo ""
echo "Common FVM commands:"
echo "  fvm flutter run          # Run the app"
echo "  fvm flutter test         # Run tests"
echo "  fvm flutter doctor       # Check Flutter setup"
echo "  fvm list                 # List installed versions"
echo "  fvm releases             # List available versions"