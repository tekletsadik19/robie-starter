#!/bin/bash

# Flutter Flavor Build Script
# Builds the app for different environments/flavors

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Determine Flutter command
if command -v fvm &> /dev/null; then
    FLUTTER_CMD="fvm flutter"
    echo -e "${GREEN}✅ Using FVM${NC}"
else
    FLUTTER_CMD="flutter"
    echo -e "${YELLOW}⚠️  Using system Flutter${NC}"
fi

# Function to print step
print_step() {
    echo -e "\n${BLUE}🔧 $1${NC}"
    echo "----------------------------------------"
}

# Function to build for specific flavor
build_flavor() {
    local flavor=$1
    local target=$2
    local build_mode=$3
    local platform=$4
    
    print_step "Building $flavor flavor for $platform ($build_mode)"
    
    case $platform in
        "android")
            $FLUTTER_CMD build apk \
                --target="lib/main_$flavor.dart" \
                --flavor="$flavor" \
                --$build_mode \
                --build-name="1.0.0-$flavor" \
                --build-number="1"
            ;;
        "ios")
            $FLUTTER_CMD build ios \
                --target="lib/main_$flavor.dart" \
                --flavor="$flavor" \
                --$build_mode \
                --build-name="1.0.0-$flavor" \
                --build-number="1"
            ;;
        "web")
            $FLUTTER_CMD build web \
                --target="lib/main_$flavor.dart" \
                --$build_mode \
                --web-renderer="canvaskit"
            ;;
        *)
            echo -e "${RED}❌ Unknown platform: $platform${NC}"
            return 1
            ;;
    esac
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [FLAVOR] [PLATFORM] [MODE]"
    echo ""
    echo "FLAVOR:"
    echo "  development  - Development build with debug features"
    echo "  staging      - Staging build for testing"
    echo "  production   - Production build for release"
    echo "  all          - Build all flavors"
    echo ""
    echo "PLATFORM:"
    echo "  android      - Build for Android"
    echo "  ios          - Build for iOS"
    echo "  web          - Build for Web"
    echo "  all          - Build for all platforms"
    echo ""
    echo "MODE:"
    echo "  debug        - Debug build"
    echo "  profile      - Profile build"
    echo "  release      - Release build"
    echo ""
    echo "Examples:"
    echo "  $0 development android debug"
    echo "  $0 production all release"
    echo "  $0 all android release"
}

# Parse arguments
FLAVOR=${1:-"development"}
PLATFORM=${2:-"android"}
MODE=${3:-"debug"}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_usage
    exit 0
fi

echo "🚀 Flutter Flavor Build Script"
echo "==============================="
echo "Flavor: $FLAVOR"
echo "Platform: $PLATFORM"
echo "Mode: $MODE"
echo ""

# Clean before building
print_step "Cleaning previous builds"
$FLUTTER_CMD clean

# Get dependencies
print_step "Getting dependencies"
$FLUTTER_CMD packages get

# Run build_runner if needed
print_step "Running build_runner"
if find lib -name "*.dart" -exec grep -l "@freezed\|@injectable\|@JsonSerializable" {} \; | head -1 > /dev/null; then
    $FLUTTER_CMD packages pub run build_runner build --delete-conflicting-outputs
fi

# Build based on parameters
if [ "$FLAVOR" = "all" ]; then
    FLAVORS=("development" "staging" "production")
else
    FLAVORS=("$FLAVOR")
fi

if [ "$PLATFORM" = "all" ]; then
    PLATFORMS=("android" "web")  # iOS requires macOS
else
    PLATFORMS=("$PLATFORM")
fi

# Build all combinations
for flavor in "${FLAVORS[@]}"; do
    for platform in "${PLATFORMS[@]}"; do
        if build_flavor "$flavor" "lib/main_$flavor.dart" "$MODE" "$platform"; then
            echo -e "${GREEN}✅ Successfully built $flavor for $platform${NC}"
        else
            echo -e "${RED}❌ Failed to build $flavor for $platform${NC}"
            exit 1
        fi
    done
done

echo -e "\n${GREEN}🎉 Build completed successfully!${NC}"
echo "==============================="

# Show build artifacts
print_step "Build artifacts"
if [ -d "build/app/outputs/flutter-apk" ]; then
    echo "Android APKs:"
    ls -la build/app/outputs/flutter-apk/*.apk 2>/dev/null || echo "No APK files found"
fi

if [ -d "build/web" ]; then
    echo "Web build:"
    du -sh build/web 2>/dev/null || echo "No web build found"
fi

if [ -d "build/ios" ]; then
    echo "iOS build:"
    ls -la build/ios/ 2>/dev/null || echo "No iOS build found"
fi

echo ""
echo "Next steps:"
echo "  - Test the builds on target devices"
echo "  - Upload to app stores or deploy to web"
echo "  - Run integration tests"