#!/bin/bash

# Project Configuration Script Wrapper
# This script runs the Python configuration script with proper error handling

set -e  # Exit on any error

echo "🔧 Flutter Project Configuration Tool"
echo "====================================="

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed"
    echo "Please install Python 3 and try again"
    exit 1
fi

# Check if PyYAML is available
if ! python3 -c "import yaml" &> /dev/null; then
    echo "📦 Installing PyYAML..."
    pip3 install PyYAML
fi

# Check if configuration file exists
if [ ! -f "config/project_config.yaml" ]; then
    echo "❌ Configuration file not found: config/project_config.yaml"
    echo "Please create the configuration file first"
    exit 1
fi

# Run the configuration script
echo "🚀 Running configuration script..."
python3 scripts/configure_project.py

echo ""
echo "✨ Configuration completed!"
echo ""
echo "Next steps:"
echo "1. Review the changes in your project files"
echo "2. Run 'flutter clean' to clean the build cache"
echo "3. Run 'flutter pub get' to update dependencies"
echo "4. Test your app with the new configuration"
echo ""
<<<<<<< Current (Your changes)
echo "💡 To revert changes, restore from .backup files"
=======
echo "💡 Make sure to commit your changes to version control before running"
>>>>>>> Incoming (Background Agent changes)
