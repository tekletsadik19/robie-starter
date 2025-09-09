#!/bin/bash

echo "🚀 Testing Hive Migration with FVM..."
echo ""

# Check if FVM is available
if command -v fvm &> /dev/null; then
    echo "✅ Using FVM for Flutter commands"
    FLUTTER_CMD="fvm flutter"
else
    echo "⚠️  FVM not found, using system Flutter"
    FLUTTER_CMD="flutter"
fi

# Test just our Hive migration
echo "1. Testing Hive Migration Implementation..."
$FLUTTER_CMD test test/shared/infrastructure/security/hive_migration_test.dart

echo ""
echo "2. Testing all tests..."
$FLUTTER_CMD test

echo ""
echo "✅ Migration testing completed!"