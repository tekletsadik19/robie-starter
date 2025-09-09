#!/usr/bin/env python3
"""
Project Configuration Script
This script reads the project_config.yaml file and applies all configuration changes
to the Flutter project files.
"""

import os
import re
import yaml
import shutil
from pathlib import Path
from typing import Dict, Any

class ProjectConfigurator:
    def __init__(self, config_path: str = "config/project_config.yaml"):
        self.config_path = config_path
        self.config = self.load_config()
        self.project_root = Path(".")
        
    def load_config(self) -> Dict[str, Any]:
        """Load configuration from YAML file"""
        try:
            with open(self.config_path, 'r', encoding='utf-8') as file:
                return yaml.safe_load(file)
        except FileNotFoundError:
            print(f"❌ Configuration file not found: {self.config_path}")
            exit(1)
        except yaml.YAMLError as e:
            print(f"❌ Error parsing configuration file: {e}")
            exit(1)
    
    
    def update_pubspec_yaml(self):
        """Update pubspec.yaml with new project details"""
        pubspec_path = self.project_root / "pubspec.yaml"
        if not pubspec_path.exists():
            print("❌ pubspec.yaml not found")
            return
            
        
        with open(pubspec_path, 'r', encoding='utf-8') as file:
            content = file.read()
        
        # Update project name
        content = re.sub(
            r'^name:\s*.*$',
            f'name: {self.config["project"]["name"].lower().replace(" ", "_")}',
            content,
            flags=re.MULTILINE
        )
        
        # Update description
        content = re.sub(
            r'^description:\s*.*$',
            f'description: {self.config["project"]["description"]}',
            content,
            flags=re.MULTILINE
        )
        
        # Update version
        content = re.sub(
            r'^version:\s*.*$',
            f'version: {self.config["project"]["version"]}+{self.config["project"]["build_number"]}',
            content,
            flags=re.MULTILINE
        )
        
        # Note: We don't update the Flutter SDK version as it's already correct
        # and updating it can cause issues with the sdk: flutter references
        
        with open(pubspec_path, 'w', encoding='utf-8') as file:
            file.write(content)
        
        print(f"✅ Updated pubspec.yaml")
    
    def update_android_config(self):
        """Update Android configuration files"""
        android_dir = self.project_root / "android"
        if not android_dir.exists():
            print("❌ Android directory not found")
            return
        
        # Update build.gradle
        build_gradle_path = android_dir / "app" / "build.gradle"
        if build_gradle_path.exists():
            
            with open(build_gradle_path, 'r', encoding='utf-8') as file:
                content = file.read()
            
            # Update namespace
            content = re.sub(
                r'namespace\s+".*"',
                f'namespace "{self.config["project"]["package_name"]}"',
                content
            )
            
            # Update applicationId
            content = re.sub(
                r'applicationId\s+".*"',
                f'applicationId "{self.config["project"]["package_name"]}"',
                content
            )
            
            # Update minSdkVersion
            content = re.sub(
                r'minSdkVersion\s+flutter\.minSdkVersion',
                f'minSdkVersion {self.config["android"]["min_sdk_version"]}',
                content
            )
            
            # Update targetSdkVersion
            content = re.sub(
                r'targetSdkVersion\s+flutter\.targetSdkVersion',
                f'targetSdkVersion {self.config["android"]["target_sdk_version"]}',
                content
            )
            
            # Update compileSdkVersion
            content = re.sub(
                r'compileSdkVersion\s+flutter\.compileSdkVersion',
                f'compileSdkVersion {self.config["android"]["compile_sdk_version"]}',
                content
            )
            
            # Update flavor names - we'll do this manually for each flavor
            # Production flavor
            content = re.sub(
                r'production\s*{[^}]*manifestPlaceholders\s*=\s*\[appName:\s*"[^"]*"\][^}]*}',
                f'production {{\n            dimension "default"\n            applicationIdSuffix ""\n            manifestPlaceholders = [appName: "{self.config["flavors"]["production"]["app_name"]}"]\n        }}',
                content,
                flags=re.DOTALL
            )
            
            # Staging flavor
            content = re.sub(
                r'staging\s*{[^}]*manifestPlaceholders\s*=\s*\[appName:\s*"[^"]*"\][^}]*}',
                f'staging {{\n            dimension "default"\n            applicationIdSuffix ".stg"\n            manifestPlaceholders = [appName: "{self.config["flavors"]["staging"]["app_name"]}"]\n        }}',
                content,
                flags=re.DOTALL
            )
            
            # Development flavor
            content = re.sub(
                r'development\s*{[^}]*manifestPlaceholders\s*=\s*\[appName:\s*"[^"]*"\][^}]*}',
                f'development {{\n            dimension "default"\n            applicationIdSuffix ".dev"\n            manifestPlaceholders = [appName: "{self.config["flavors"]["development"]["app_name"]}"]\n        }}',
                content,
                flags=re.DOTALL
            )
            
            with open(build_gradle_path, 'w', encoding='utf-8') as file:
                file.write(content)
            
            print(f"✅ Updated Android build.gradle")
    
    def update_ios_config(self):
        """Update iOS configuration files"""
        ios_dir = self.project_root / "ios"
        if not ios_dir.exists():
            print("❌ iOS directory not found")
            return
        
        # Update Info.plist
        info_plist_path = ios_dir / "Runner" / "Info.plist"
        if info_plist_path.exists():
            
            with open(info_plist_path, 'r', encoding='utf-8') as file:
                content = file.read()
            
            # Update CFBundleDisplayName
            content = re.sub(
                r'<key>CFBundleDisplayName</key>\s*<string>.*?</string>',
                f'<key>CFBundleDisplayName</key>\n\t<string>{self.config["project"]["display_name"]}</string>',
                content,
                flags=re.DOTALL
            )
            
            # Update CFBundleName
            content = re.sub(
                r'<key>CFBundleName</key>\s*<string>.*?</string>',
                f'<key>CFBundleName</key>\n\t<string>{self.config["project"]["display_name"]}</string>',
                content,
                flags=re.DOTALL
            )
            
            with open(info_plist_path, 'w', encoding='utf-8') as file:
                file.write(content)
            
            print(f"✅ Updated iOS Info.plist")
        
        # Update project.pbxproj
        project_path = ios_dir / "Runner.xcodeproj" / "project.pbxproj"
        if project_path.exists():
            
            with open(project_path, 'r', encoding='utf-8') as file:
                content = file.read()
            
            # Update PRODUCT_BUNDLE_IDENTIFIER
            content = re.sub(
                r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*[^;]+;',
                f'PRODUCT_BUNDLE_IDENTIFIER = {self.config["project"]["package_name"]};',
                content
            )
            
            # Update PRODUCT_NAME
            content = re.sub(
                r'PRODUCT_NAME\s*=\s*[^;]+;',
                f'PRODUCT_NAME = {self.config["project"]["name"].replace(" ", "")};',
                content
            )
            
            with open(project_path, 'w', encoding='utf-8') as file:
                file.write(content)
            
            print(f"✅ Updated iOS project.pbxproj")
    
    def update_dart_files(self):
        """Update Dart files with new package name"""
        lib_dir = self.project_root / "lib"
        if not lib_dir.exists():
            print("❌ lib directory not found")
            return
        
        # Since we're changing from ddd_flutter_app to shemanit, we know the old name
        old_package_name = "ddd_flutter_app"
        new_package_name = self.config["project"]["name"].lower().replace(" ", "_")
        
        print(f"🔄 Updating package imports from '{old_package_name}' to '{new_package_name}'")
        
        # Update all Dart files
        for dart_file in lib_dir.rglob("*.dart"):
            
            with open(dart_file, 'r', encoding='utf-8') as file:
                content = file.read()
            
            # Update import statements
            old_import = f'package:{old_package_name}/'
            new_import = f'package:{new_package_name}/'
            content = content.replace(old_import, new_import)
            
            with open(dart_file, 'w', encoding='utf-8') as file:
                file.write(content)
        
        print(f"✅ Updated Dart files with new package name")
    
    def create_readme(self):
        """Create or update README with configuration details"""
        readme_path = self.project_root / "README.md"
        
        readme_content = f"""# {self.config["project"]["name"]}

{self.config["project"]["description"]}

## Configuration

This project was configured using the automated configuration system.

### Project Details
- **Name**: {self.config["project"]["name"]}
- **Version**: {self.config["project"]["version"]}
- **Package**: {self.config["project"]["package_name"]}
- **Company**: {self.config["project"]["company"]["name"]}

### Build Flavors
"""
        
        for flavor_name, flavor_config in self.config["flavors"].items():
            readme_content += f"- **{flavor_config['name']}**: {flavor_config['app_name']}\n"
        
        readme_content += f"""
### Features
"""
        
        for feature, enabled in self.config["features"].items():
            status = "✅" if enabled else "❌"
            readme_content += f"- {status} {feature.replace('_', ' ').title()}\n"
        
        readme_content += f"""
## Development

To modify the project configuration, edit `config/project_config.yaml` and run:

```bash
python scripts/configure_project.py
```

## Company Information
- **Website**: {self.config["project"]["company"]["website"]}
- **Email**: {self.config["project"]["company"]["email"]}
"""
        
        with open(readme_path, 'w', encoding='utf-8') as file:
            file.write(readme_content)
        
        print(f"✅ Updated README.md")
    
    def run(self):
        """Run the complete configuration process"""
        print("🚀 Starting project configuration...")
        print(f"📁 Project: {self.config['project']['name']}")
        print(f"📦 Package: {self.config['project']['package_name']}")
        print()
        
        try:
            self.update_pubspec_yaml()
            self.update_android_config()
            self.update_ios_config()
            self.update_dart_files()
            self.create_readme()
            
            print()
            print("🎉 Project configuration completed successfully!")
            print("🔄 You may need to run 'flutter clean' and 'flutter pub get'")
            
        except Exception as e:
            print(f"❌ Error during configuration: {e}")
            exit(1)

def main():
    configurator = ProjectConfigurator()
    configurator.run()

if __name__ == "__main__":
    main()
