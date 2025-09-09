import 'package:flutter/material.dart';

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  /// Get theme data
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => mediaQuery.size;

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height
  double get screenHeight => screenSize.height;

  /// Check if device is mobile
  bool get isMobile => screenWidth < 768;

  /// Check if device is tablet
  bool get isTablet => screenWidth >= 768 && screenWidth < 1024;

  /// Check if device is desktop
  bool get isDesktop => screenWidth >= 1024;

  /// Get safe area padding
  EdgeInsets get padding => mediaQuery.padding;

  /// Get view insets (keyboard height)
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Show snackbar with message
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: colorScheme.error);
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }

  /// Navigate to route
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  /// Replace current route
  Future<T?> pushReplacementNamed<T, TO>(
    String routeName, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushReplacementNamed<T, TO>(
        routeName,
        arguments: arguments,
      );

  /// Pop current route
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }
}
