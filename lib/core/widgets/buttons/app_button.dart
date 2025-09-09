import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shemanit/core/accessibility/accessibility_utils.dart';
import 'package:shemanit/core/responsive/responsive_utils.dart';

/// Enumeration for button variants
enum AppButtonVariant {
  primary,
  secondary,
  outlined,
  text,
  destructive,
}

/// Enumeration for button sizes
enum AppButtonSize {
  small,
  medium,
  large,
}

/// Platform-adaptive button widget with accessibility support and hooks
class AppButton extends HookWidget {
  const AppButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.hapticFeedback = true,
    this.loadingText,
    this.animationDuration,
  });

  /// Convenience constructor for primary button
  const AppButton.primary({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.hapticFeedback = true,
    this.loadingText,
    this.animationDuration,
  }) : variant = AppButtonVariant.primary;

  /// Convenience constructor for secondary button
  const AppButton.secondary({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.hapticFeedback = true,
    this.loadingText,
    this.animationDuration,
  }) : variant = AppButtonVariant.secondary;

  /// Convenience constructor for outlined button
  const AppButton.outlined({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.hapticFeedback = true,
    this.loadingText,
    this.animationDuration,
  }) : variant = AppButtonVariant.outlined;

  /// Convenience constructor for text button
  const AppButton.text({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.hapticFeedback = true,
    this.loadingText,
    this.animationDuration,
  }) : variant = AppButtonVariant.text;

  /// Convenience constructor for destructive button
  const AppButton.destructive({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.hapticFeedback = true,
    this.loadingText,
    this.animationDuration,
  }) : variant = AppButtonVariant.destructive;

  final VoidCallback? onPressed;
  final Widget child;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isEnabled;
  final bool fullWidth;
  final Widget? icon;
  final String? semanticLabel;
  final String? tooltip;
  final Duration debounceDelay;
  final bool hapticFeedback;
  final String? loadingText;
  final Duration? animationDuration;

  @override
  Widget build(BuildContext context) {
    // Hooks for state management
    final isPressed = useState(false);
    final isFocused = useState(false);
    final isHovered = useState(false);

    // Animation controller for loading state
    final animationController = useAnimationController(
      duration: animationDuration ?? const Duration(milliseconds: 200),
    );

    // Debounced callback to prevent rapid taps
    final debouncedCallback = useMemoized(
      () {
        if (onPressed == null) return null;

        Timer? debounceTimer;
        return () {
          debounceTimer?.cancel();
          debounceTimer = Timer(debounceDelay, () {
            if (hapticFeedback) {
              HapticFeedback.lightImpact();
            }
            onPressed!();
          });
        };
      },
      [onPressed, debounceDelay, hapticFeedback],
    );

    // Handle loading state animation
    useEffect(
      () {
        if (isLoading) {
          animationController.repeat();
        } else {
          animationController.stop();
        }
        return null;
      },
      [isLoading],
    );

    final isEffectivelyEnabled =
        isEnabled && !isLoading && debouncedCallback != null;

    var button = _buildPlatformButton(
      context,
      isEffectivelyEnabled,
      debouncedCallback,
      isPressed,
      isFocused,
      isHovered,
      animationController,
    );

    if (fullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    // Add tooltip if provided
    if (tooltip != null) {
      button = Tooltip(
        message: tooltip,
        child: button,
      );
    }

    // Add semantic label for accessibility
    if (semanticLabel != null) {
      button = Semantics(
        label: semanticLabel,
        button: true,
        enabled: isEffectivelyEnabled,
        child: button,
      );
    } else {
      final autoLabel = AccessibilityUtils.createButtonLabel(
        label: _extractTextFromWidget(child),
        isEnabled: isEffectivelyEnabled,
        isLoading: isLoading,
      );
      button = Semantics(
        label: autoLabel,
        button: true,
        enabled: isEffectivelyEnabled,
        child: button,
      );
    }

    return button;
  }

  Widget _buildPlatformButton(
    BuildContext context,
    bool isEffectivelyEnabled,
    VoidCallback? debouncedCallback,
    ValueNotifier<bool> isPressed,
    ValueNotifier<bool> isFocused,
    ValueNotifier<bool> isHovered,
    AnimationController animationController,
  ) {
    // Use Cupertino buttons on iOS for native feel
    if (Platform.isIOS) {
      return _buildCupertinoButton(
        context,
        debouncedCallback,
        animationController,
      );
    }

    // Use Material buttons on Android and other platforms
    return _buildMaterialButton(
      context,
      debouncedCallback,
      isPressed,
      isFocused,
      isHovered,
      animationController,
    );
  }

  Widget _buildCupertinoButton(
    BuildContext context,
    VoidCallback? debouncedCallback,
    AnimationController animationController,
  ) {
    final theme = Theme.of(context);
    final buttonChild = _buildButtonChild(context, animationController);
    final padding = _getButtonPadding(context);

    switch (variant) {
      case AppButtonVariant.primary:
        return CupertinoButton.filled(
          onPressed: debouncedCallback,
          padding: padding,
          child: buttonChild,
        );

      case AppButtonVariant.secondary:
      case AppButtonVariant.outlined:
        return CupertinoButton(
          onPressed: debouncedCallback,
          padding: padding,
          color: theme.colorScheme.surfaceContainerHighest,
          child: buttonChild,
        );

      case AppButtonVariant.text:
        return CupertinoButton(
          onPressed: debouncedCallback,
          padding: padding,
          child: buttonChild,
        );

      case AppButtonVariant.destructive:
        return CupertinoButton.filled(
          onPressed: debouncedCallback,
          padding: padding,
          child: buttonChild,
        );
    }
  }

  Widget _buildMaterialButton(
    BuildContext context,
    VoidCallback? debouncedCallback,
    ValueNotifier<bool> isPressed,
    ValueNotifier<bool> isFocused,
    ValueNotifier<bool> isHovered,
    AnimationController animationController,
  ) {
    final buttonChild = _buildButtonChild(context, animationController);
    final theme = Theme.of(context);

    final Widget button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: debouncedCallback,
          style: ElevatedButton.styleFrom(
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        ),
      AppButtonVariant.secondary => ElevatedButton(
          onPressed: debouncedCallback,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            foregroundColor: theme.colorScheme.onSurfaceVariant,
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        ),
      AppButtonVariant.outlined => OutlinedButton(
          onPressed: debouncedCallback,
          style: OutlinedButton.styleFrom(
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: debouncedCallback,
          style: TextButton.styleFrom(
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        ),
      AppButtonVariant.destructive => ElevatedButton(
          onPressed: debouncedCallback,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        ),
    };

    // Add interaction handlers for enhanced feedback
    return GestureDetector(
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) => isPressed.value = false,
      onTapCancel: () => isPressed.value = false,
      child: Focus(
        onFocusChange: (focused) => isFocused.value = focused,
        child: MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: button,
        ),
      ),
    );
  }

  Widget _buildButtonChild(
    BuildContext context,
    AnimationController animationController,
  ) {
    if (isLoading) {
      return _buildLoadingIndicator(context, animationController);
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          child,
        ],
      );
    }

    return child;
  }

  Widget _buildLoadingIndicator(
    BuildContext context,
    AnimationController animationController,
  ) {
    final theme = Theme.of(context);
    final size = _getLoadingIndicatorSize();

    final indicator = Platform.isIOS
        ? CupertinoActivityIndicator(
            radius: size / 2,
            color: theme.colorScheme.onPrimary,
          )
        : SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.onPrimary,
              ),
            ),
          );

    // Add loading text if provided
    if (loadingText != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator,
          const SizedBox(width: 8),
          Text(loadingText!),
        ],
      );
    }

    return indicator;
  }

  String _extractTextFromWidget(Widget widget) {
    if (widget is Text) {
      return widget.data ?? widget.textSpan?.toPlainText() ?? 'Button';
    }
    return 'Button';
  }

  EdgeInsets _getButtonPadding(BuildContext context) {
    return ResponsiveUtils.responsiveValue(
      context: context,
      mobile: switch (size) {
        AppButtonSize.small =>
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        AppButtonSize.medium =>
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        AppButtonSize.large =>
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      },
      tablet: switch (size) {
        AppButtonSize.small =>
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        AppButtonSize.medium =>
          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        AppButtonSize.large =>
          const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      },
      desktop: switch (size) {
        AppButtonSize.small =>
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        AppButtonSize.medium =>
          const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        AppButtonSize.large =>
          const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      },
    );
  }

  Size _getMinimumSize(BuildContext context) {
    return ResponsiveUtils.responsiveValue(
      context: context,
      mobile: switch (size) {
        AppButtonSize.small => const Size(64, 32),
        AppButtonSize.medium => const Size(80, 40),
        AppButtonSize.large => const Size(96, 48),
      },
      tablet: switch (size) {
        AppButtonSize.small => const Size(72, 36),
        AppButtonSize.medium => const Size(88, 44),
        AppButtonSize.large => const Size(104, 52),
      },
      desktop: switch (size) {
        AppButtonSize.small => const Size(80, 40),
        AppButtonSize.medium => const Size(96, 48),
        AppButtonSize.large => const Size(112, 56),
      },
    );
  }

  double _getLoadingIndicatorSize() {
    return switch (size) {
      AppButtonSize.small => 16,
      AppButtonSize.medium => 20,
      AppButtonSize.large => 24,
    };
  }
}
