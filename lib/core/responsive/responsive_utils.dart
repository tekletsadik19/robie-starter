import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Responsive design utilities for creating adaptive layouts
class ResponsiveUtils {
  ResponsiveUtils._();

  // Breakpoints
  static const double mobileBreakpoint = 576;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 992;
  static const double largeDesktopBreakpoint = 1200;

  // Spacing
  static const double spacing4 = 4;
  static const double spacing8 = 8;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing20 = 20;
  static const double spacing24 = 24;
  static const double spacing32 = 32;
  static const double spacing40 = 40;
  static const double spacing48 = 48;
  static const double spacing64 = 64;

  // Grid columns
  static const int mobileColumns = 4;
  static const int tabletColumns = 8;
  static const int desktopColumns = 12;

  /// Get device type based on screen width
  static DeviceType getDeviceType(double width) {
    if (width < mobileBreakpoint) return DeviceType.mobile;
    if (width < tabletBreakpoint) return DeviceType.mobileLarge;
    if (width < desktopBreakpoint) return DeviceType.tablet;
    if (width < largeDesktopBreakpoint) return DeviceType.desktop;
    return DeviceType.largeDesktop;
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return ResponsiveBreakpoints.of(context).smallerThan(TABLET);
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return ResponsiveBreakpoints.of(context).between(TABLET, DESKTOP);
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return ResponsiveBreakpoints.of(context).largerThan(TABLET);
  }

  /// Check if device is web platform
  static bool isWeb() {
    return kIsWeb;
  }

  /// Get responsive value based on device type
  static T responsiveValue<T>({
    required BuildContext context,
    required T mobile,
    T? mobileLarge,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final breakpoints = ResponsiveBreakpoints.of(context);

    if (breakpoints.largerThan(DESKTOP) && largeDesktop != null) {
      return largeDesktop;
    } else if (breakpoints.largerThan(TABLET) && desktop != null) {
      return desktop;
    } else if (breakpoints.between(TABLET, DESKTOP) && tablet != null) {
      return tablet;
    } else if (breakpoints.between(MOBILE, TABLET) && mobileLarge != null) {
      return mobileLarge;
    } else {
      return mobile;
    }
  }

  /// Get responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: responsiveValue(
        context: context,
        mobile: spacing16,
        tablet: spacing24,
        desktop: spacing32,
      ),
      vertical: responsiveValue(
        context: context,
        mobile: spacing16,
        tablet: spacing20,
        desktop: spacing24,
      ),
    );
  }

  /// Get responsive margin
  static EdgeInsets responsiveMargin(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: responsiveValue(
        context: context,
        mobile: spacing8,
        tablet: spacing16,
        desktop: spacing24,
      ),
      vertical: responsiveValue(
        context: context,
        mobile: spacing8,
        tablet: spacing12,
        desktop: spacing16,
      ),
    );
  }

  /// Get responsive font size
  static double responsiveFontSize({
    required BuildContext context,
    required double baseFontSize,
    double scaleFactor = 0.1,
  }) {
    final deviceType = getDeviceType(MediaQuery.of(context).size.width);

    return switch (deviceType) {
      DeviceType.mobile => baseFontSize - (baseFontSize * scaleFactor),
      DeviceType.mobileLarge => baseFontSize,
      DeviceType.tablet => baseFontSize + (baseFontSize * scaleFactor * 0.5),
      DeviceType.desktop => baseFontSize + (baseFontSize * scaleFactor),
      DeviceType.largeDesktop =>
        baseFontSize + (baseFontSize * scaleFactor * 1.5),
    };
  }

  /// Get number of columns for grid layout
  static int getGridColumns(BuildContext context) {
    return responsiveValue(
      context: context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );
  }

  /// Get container max width for content
  static double getMaxContentWidth(BuildContext context) {
    return responsiveValue(
      context: context,
      mobile: double.infinity,
      tablet: 768,
      desktop: 1024,
      largeDesktop: 1200,
    );
  }

  /// Get responsive border radius
  static BorderRadius responsiveBorderRadius(BuildContext context) {
    final radius = responsiveValue(
      context: context,
      mobile: 8,
      tablet: 12,
      desktop: 16,
    );
    return BorderRadius.circular(radius as double);
  }

  /// Get responsive elevation
  static double responsiveElevation(BuildContext context) {
    return responsiveValue(
      context: context,
      mobile: 2,
      tablet: 4,
      desktop: 6,
    );
  }

  /// Calculate responsive width percentage
  static double responsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  /// Calculate responsive height percentage
  static double responsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get screen size information
  static ScreenSize getScreenSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceType = getDeviceType(size.width);
    final orientation = MediaQuery.of(context).orientation;

    return ScreenSize(
      width: size.width,
      height: size.height,
      deviceType: deviceType,
      orientation: orientation,
      isLandscape: orientation == Orientation.landscape,
      isPortrait: orientation == Orientation.portrait,
    );
  }
}

/// Device type enumeration
enum DeviceType {
  mobile,
  mobileLarge,
  tablet,
  desktop,
  largeDesktop,
}

/// Screen size information class
class ScreenSize {
  const ScreenSize({
    required this.width,
    required this.height,
    required this.deviceType,
    required this.orientation,
    required this.isLandscape,
    required this.isPortrait,
  });

  final double width;
  final double height;
  final DeviceType deviceType;
  final Orientation orientation;
  final bool isLandscape;
  final bool isPortrait;

  @override
  String toString() {
    return 'ScreenSize(width: $width, height: $height, deviceType: $deviceType, orientation: $orientation)';
  }
}

/// Responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.mobile,
    super.key,
    this.mobileLarge,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveUtils.responsiveValue(
      context: context,
      mobile: mobile,
      mobileLarge: mobileLarge,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }
}

/// Responsive container with max width constraints
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.maxWidth,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? maxWidth;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? ResponsiveUtils.getMaxContentWidth(context),
        ),
        child: Padding(
          padding: padding ?? ResponsiveUtils.responsivePadding(context),
          child: child,
        ),
      ),
    );
  }
}

/// Responsive grid widget
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    required this.children,
    super.key,
    this.spacing = ResponsiveUtils.spacing16,
    this.runSpacing,
    this.maxCrossAxisExtent,
    this.childAspectRatio = 1.0,
  });

  final List<Widget> children;
  final double spacing;
  final double? runSpacing;
  final double? maxCrossAxisExtent;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.getGridColumns(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveSpacing = spacing;
    final totalSpacing = effectiveSpacing * (columns - 1);
    final availableWidth = screenWidth - totalSpacing;
    final itemWidth = availableWidth / columns;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent ?? itemWidth,
        mainAxisSpacing: runSpacing ?? spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
