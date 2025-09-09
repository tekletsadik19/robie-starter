# shemanit

A fantastic Flutter application by shemanit.co

## Configuration

This project was configured using the automated configuration system.

### Project Details
- **Name**: shemanit
- **Description**: A fantastic Flutter application by shemanit.co
- **Version**: 1.0.0+1

### Features
- Clean Architecture with Domain-Driven Design
- State Management with BLoC
- Dependency Injection with GetIt and Injectable
- Secure caching with Hive and SHA-256 encryption
- Comprehensive error handling
- Internationalization support
- Testing setup with comprehensive test coverage

### Getting Started

1. **Install dependencies**:
   ```bash
   fvm flutter packages get
   ```

2. **Run code generation**:
   ```bash
   fvm flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run the app**:
   ```bash
   fvm flutter run
   ```

4. **Run tests**:
   ```bash
   fvm flutter test
   ```

### Architecture

This project follows Clean Architecture principles with Domain-Driven Design:

- **Domain Layer**: Entities, repositories, and use cases
- **Infrastructure Layer**: Data sources, external services
- **Application Layer**: Business logic and use cases
- **Presentation Layer**: UI components and state management

### Security

- **Hive Database**: Encrypted local storage with SHA-256 security
- **Data Integrity**: Built-in corruption detection and verification
- **Secure Storage**: Separate encryption keys for different data types