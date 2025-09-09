import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Accessibility utilities and helpers
class AccessibilityUtils {
  AccessibilityUtils._();

  /// Check if screen reader is enabled
  static bool isScreenReaderEnabled(BuildContext context) {
    return MediaQuery.of(context).accessibleNavigation;
  }

  /// Check if high contrast is enabled
  static bool isHighContrastEnabled(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }

  /// Check if bold text is enabled
  static bool isBoldTextEnabled(BuildContext context) {
    return MediaQuery.of(context).boldText;
  }

  /// Get text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1);
  }

  /// Get safe text scale factor (clamped between reasonable bounds)
  static double getSafeTextScaleFactor(
    BuildContext context, {
    double min = 0.8,
    double max = 2.0,
  }) {
    final scaleFactor = getTextScaleFactor(context);
    return scaleFactor.clamp(min, max);
  }

  /// Announce to screen reader
  static void announce(String message) {
    // Use SemanticsService for announcements
    SemanticsService.announce(message, TextDirection.ltr);
  }

  /// Announce to screen reader with priority
  static void announceWithPriority(String message, {bool assertive = false}) {
    // Use SemanticsService for announcements
    SemanticsService.announce(message, TextDirection.ltr);
  }

  /// Create semantic label for complex widgets
  static String createSemanticLabel({
    String? label,
    String? value,
    String? hint,
    String? role,
    List<String>? additionalInfo,
  }) {
    final parts = <String>[];

    if (role != null) parts.add(role);
    if (label != null) parts.add(label);
    if (value != null) parts.add(value);
    if (hint != null) parts.add(hint);
    if (additionalInfo != null) parts.addAll(additionalInfo);

    return parts.join(', ');
  }

  /// Create button semantic label
  static String createButtonLabel({
    required String label,
    bool isEnabled = true,
    bool isLoading = false,
    String? additionalInfo,
  }) {
    final parts = <String>[label];

    if (isLoading) {
      parts.add('loading');
    } else if (!isEnabled) {
      parts.add('disabled');
    }

    if (additionalInfo != null) {
      parts.add(additionalInfo);
    }

    parts.add('button');
    return parts.join(', ');
  }

  /// Create input field semantic label
  static String createInputLabel({
    required String label,
    bool isRequired = false,
    bool hasError = false,
    String? value,
    String? hint,
  }) {
    final parts = <String>[label];

    if (isRequired) parts.add('required');
    if (hasError) parts.add('has error');
    if (value != null && value.isNotEmpty) parts.add('current value: $value');
    if (hint != null) parts.add('hint: $hint');

    parts.add('text field');
    return parts.join(', ');
  }

  /// Create list item semantic label
  static String createListItemLabel({
    required String title,
    String? subtitle,
    String? metadata,
    int? position,
    int? total,
  }) {
    final parts = <String>[title];

    if (subtitle != null) parts.add(subtitle);
    if (metadata != null) parts.add(metadata);

    if (position != null && total != null) {
      parts.add('item $position of $total');
    }

    return parts.join(', ');
  }

  /// Create progress semantic label
  static String createProgressLabel({
    required double progress,
    String? label,
    bool isIndeterminate = false,
  }) {
    if (isIndeterminate) {
      return label != null ? '$label, loading' : 'loading';
    }

    final percentage = (progress * 100).round();
    final progressText = '$percentage percent complete';

    return label != null ? '$label, $progressText' : progressText;
  }

  /// Create navigation semantic label
  static String createNavigationLabel({
    required String destination,
    bool isBack = false,
    bool isForward = false,
  }) {
    if (isBack) return 'go back to $destination';
    if (isForward) return 'go forward to $destination';
    return 'navigate to $destination';
  }

  /// Get recommended minimum touch target size
  static Size getMinimumTouchTargetSize() {
    return const Size(44, 44); // Following accessibility guidelines
  }

  /// Check if touch target meets accessibility standards
  static bool isTouchTargetAccessible(Size size) {
    final minSize = getMinimumTouchTargetSize();
    return size.width >= minSize.width && size.height >= minSize.height;
  }

  /// Get accessible color contrast ratio
  static double getContrastRatio(Color foreground, Color background) {
    final foregroundLuminance = foreground.computeLuminance();
    final backgroundLuminance = background.computeLuminance();

    final lighter = foregroundLuminance > backgroundLuminance
        ? foregroundLuminance
        : backgroundLuminance;
    final darker = foregroundLuminance < backgroundLuminance
        ? foregroundLuminance
        : backgroundLuminance;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Check if color combination meets WCAG AA standards
  static bool meetsWCAGAAStandard(
    Color foreground,
    Color background, {
    bool isLargeText = false,
  }) {
    final ratio = getContrastRatio(foreground, background);
    return isLargeText ? ratio >= 3.0 : ratio >= 4.5;
  }

  /// Check if color combination meets WCAG AAA standards
  static bool meetsWCAGAAAStandard(
    Color foreground,
    Color background, {
    bool isLargeText = false,
  }) {
    final ratio = getContrastRatio(foreground, background);
    return isLargeText ? ratio >= 4.5 : ratio >= 7.0;
  }

  /// Get accessible text style with proper scaling
  static TextStyle getAccessibleTextStyle(
    BuildContext context,
    TextStyle baseStyle,
  ) {
    final scaleFactor = getSafeTextScaleFactor(context);
    final isBold = isBoldTextEnabled(context);

    return baseStyle.copyWith(
      fontSize: (baseStyle.fontSize ?? 14) * scaleFactor,
      fontWeight: isBold ? FontWeight.bold : baseStyle.fontWeight,
    );
  }

  /// Create accessible focus decoration
  static Decoration createFocusDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      border: Border.all(
        color: theme.colorScheme.primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }

  /// Get accessible animation duration
  static Duration getAccessibleAnimationDuration(BuildContext context) {
    // Reduce animation duration for accessibility
    final reducedMotion = MediaQuery.of(context).disableAnimations;
    return reducedMotion ? Duration.zero : const Duration(milliseconds: 200);
  }

  /// Create accessible hover effects
  static WidgetStateProperty<Color?> createAccessibleHoverColor(
    Color baseColor,
    BuildContext context,
  ) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return baseColor.withValues(alpha: 0.08);
      }
      if (states.contains(WidgetState.focused)) {
        return baseColor.withValues(alpha: 0.12);
      }
      return null;
    });
  }
}

/// Accessible widget wrapper
class AccessibleWidget extends StatelessWidget {
  const AccessibleWidget({
    required this.child,
    super.key,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.focusNode,
    this.onTap,
    this.role,
    this.enabled = true,
    this.selected = false,
    this.expanded = false,
  });

  final Widget child;
  final String? semanticLabel;
  final bool excludeSemantics;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final String? role;
  final bool enabled;
  final bool selected;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    var result = child;

    if (!excludeSemantics) {
      result = Semantics(
        label: semanticLabel,
        button: onTap != null,
        enabled: enabled,
        selected: selected,
        expanded: expanded,
        focusable: focusNode != null || onTap != null,
        child: result,
      );
    }

    if (focusNode != null || onTap != null) {
      result = Focus(
        focusNode: focusNode,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(4),
          child: result,
        ),
      );
    }

    return result;
  }
}

/// Screen reader announcement widget
class ScreenReaderAnnouncement extends StatefulWidget {
  const ScreenReaderAnnouncement({
    required this.message,
    required this.child,
    super.key,
    this.assertive = false,
    this.announceOnMount = true,
  });

  final String message;
  final Widget child;
  final bool assertive;
  final bool announceOnMount;

  @override
  State<ScreenReaderAnnouncement> createState() =>
      _ScreenReaderAnnouncementState();
}

class _ScreenReaderAnnouncementState extends State<ScreenReaderAnnouncement> {
  @override
  void initState() {
    super.initState();
    if (widget.announceOnMount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AccessibilityUtils.announceWithPriority(
          widget.message,
          assertive: widget.assertive,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: widget.child,
    );
  }
}

/// Skip link widget for keyboard navigation
class SkipLink extends StatelessWidget {
  const SkipLink({
    required this.targetKey,
    required this.label,
    super.key,
  });

  final GlobalKey targetKey;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -100, // Hidden by default
      left: 0,
      child: Focus(
        onFocusChange: (hasFocus) {
          // Show when focused, hide when not focused
        },
        child: ElevatedButton(
          onPressed: () {
            // Scroll to target
            Scrollable.ensureVisible(
              targetKey.currentContext!,
              duration: const Duration(milliseconds: 200),
            );
          },
          child: Text(label),
        ),
      ),
    );
  }
}
