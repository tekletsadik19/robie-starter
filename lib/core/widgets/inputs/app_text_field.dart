import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shemanit/core/responsive/responsive_utils.dart';

/// Enumeration for text field variants
enum AppTextFieldVariant {
  standard,
  outlined,
  filled,
}

/// Platform-adaptive text field with accessibility support and hooks
class AppTextField extends HookWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.variant = AppTextFieldVariant.outlined,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.semanticLabel,
    this.isRequired = false,
    this.validator,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.animationDuration = const Duration(milliseconds: 200),
    this.autoValidate = true,
  });

  // Standard TextField properties
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool canRequestFocus;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;

  // Custom properties
  final AppTextFieldVariant variant;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? semanticLabel;
  final bool isRequired;
  final String? Function(String?)? validator;
  final Duration debounceDelay;
  final Duration animationDuration;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    // Hooks for state management
    final effectiveController = controller ?? useTextEditingController();
    final effectiveFocusNode = focusNode ?? useFocusNode();
    final errorText = useState<String?>(error);
    final isFocused = useState(false);

    // Debounced validation
    final debouncedValue = useMemoized(
      () {
        final notifier = ValueNotifier(effectiveController.text);
        Timer? debounceTimer;

        void listener() {
          debounceTimer?.cancel();
          debounceTimer = Timer(debounceDelay, () {
            notifier.value = effectiveController.text;
          });
        }

        effectiveController.addListener(listener);
        return notifier;
      },
      [effectiveController, debounceDelay],
    );

    final debouncedText = useListenable(debouncedValue).value;

    // Auto-validation with debouncing
    useEffect(
      () {
        if (autoValidate && validator != null) {
          final validationError = validator!(debouncedText);
          errorText.value = validationError;
        }
        return null;
      },
      [debouncedText, validator, autoValidate],
    );

    // Handle text changes
    final handleChanged = useCallback(
      (String value) {
        if (!autoValidate && validator != null) {
          final validationError = validator!(value);
          errorText.value = validationError;
        }
        onChanged?.call(value);
      },
      [validator, autoValidate, onChanged],
    );

    // Focus state management
    useEffect(
      () {
        void focusListener() {
          isFocused.value = effectiveFocusNode.hasFocus;
        }

        effectiveFocusNode.addListener(focusListener);
        return () => effectiveFocusNode.removeListener(focusListener);
      },
      [effectiveFocusNode],
    );

    if (Platform.isIOS && variant == AppTextFieldVariant.standard) {
      return _buildCupertinoTextField(
        context,
        effectiveController,
        effectiveFocusNode,
        errorText,
        handleChanged,
      );
    }

    return _buildMaterialTextField(
      context,
      effectiveController,
      effectiveFocusNode,
      errorText,
      handleChanged,
    );
  }

  Widget _buildCupertinoTextField(
    BuildContext context,
    TextEditingController effectiveController,
    FocusNode effectiveFocusNode,
    ValueNotifier<String?> errorText,
    ValueChanged<String> handleChanged,
  ) {
    final theme = Theme.of(context);

    final Widget textField = CupertinoTextField(
      controller: effectiveController,
      focusNode: effectiveFocusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      style: style,
      textAlign: textAlign,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      obscureText: obscureText,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChanged: handleChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled ?? true,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius ?? const Radius.circular(2),
      cursorColor: cursorColor,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      onTap: onTap,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      stylusHandwritingEnabled: scribbleEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      placeholder: hint,
      prefix: prefixIcon,
      suffix: suffixIcon,
      padding: ResponsiveUtils.responsiveValue(
        context: context,
        mobile: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        tablet: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: ResponsiveUtils.responsiveBorderRadius(context),
        border: errorText.value != null
            ? Border.all(color: theme.colorScheme.error)
            : Border.all(color: theme.colorScheme.outline),
      ),
    );

    return _wrapWithLabelsAndAccessibility(context, textField, errorText);
  }

  Widget _buildMaterialTextField(
    BuildContext context,
    TextEditingController effectiveController,
    FocusNode effectiveFocusNode,
    ValueNotifier<String?> errorText,
    ValueChanged<String> handleChanged,
  ) {
    final theme = Theme.of(context);
    final decoration = _buildInputDecoration(context, theme, errorText);

    final Widget textField = TextField(
      controller: effectiveController,
      focusNode: effectiveFocusNode,
      decoration: decoration,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      style: style,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      obscureText: obscureText,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChanged: handleChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onAppPrivateCommand: onAppPrivateCommand,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      selectionHeightStyle: selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      onTap: onTap,
      onTapOutside: onTapOutside,
      mouseCursor: mouseCursor,
      buildCounter: buildCounter,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      stylusHandwritingEnabled: scribbleEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      contextMenuBuilder: contextMenuBuilder,
      canRequestFocus: canRequestFocus,
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: magnifierConfiguration,
    );

    return _wrapWithLabelsAndAccessibility(context, textField, errorText);
  }

  InputDecoration _buildInputDecoration(
    BuildContext context,
    ThemeData theme,
    ValueNotifier<String?> errorText,
  ) {
    final baseDecoration = decoration ?? const InputDecoration();

    return baseDecoration.copyWith(
      labelText: label,
      hintText: hint,
      helperText: helper,
      errorText: errorText.value,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefix: prefix,
      suffix: suffix,
      filled: variant == AppTextFieldVariant.filled,
      border: _getBorder(context, theme),
      enabledBorder: _getBorder(context, theme),
      focusedBorder: _getFocusedBorder(context, theme),
      errorBorder: _getErrorBorder(context, theme),
      focusedErrorBorder: _getFocusedErrorBorder(context, theme),
    );
  }

  InputBorder _getBorder(BuildContext context, ThemeData theme) {
    final borderRadius = ResponsiveUtils.responsiveBorderRadius(context);

    return switch (variant) {
      AppTextFieldVariant.standard => UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
      AppTextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
      AppTextFieldVariant.filled => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        ),
    };
  }

  InputBorder _getFocusedBorder(BuildContext context, ThemeData theme) {
    final borderRadius = ResponsiveUtils.responsiveBorderRadius(context);

    return switch (variant) {
      AppTextFieldVariant.standard => UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      AppTextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      AppTextFieldVariant.filled => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
    };
  }

  InputBorder _getErrorBorder(BuildContext context, ThemeData theme) {
    final borderRadius = ResponsiveUtils.responsiveBorderRadius(context);

    return switch (variant) {
      AppTextFieldVariant.standard => UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
      AppTextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
      AppTextFieldVariant.filled => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
    };
  }

  InputBorder _getFocusedErrorBorder(BuildContext context, ThemeData theme) {
    final borderRadius = ResponsiveUtils.responsiveBorderRadius(context);

    return switch (variant) {
      AppTextFieldVariant.standard => UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
      AppTextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
      AppTextFieldVariant.filled => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
    };
  }

  Widget _wrapWithLabelsAndAccessibility(
    BuildContext context,
    Widget textField,
    ValueNotifier<String?> errorText,
  ) {
    final theme = Theme.of(context);

    var result = textField;

    // Add semantic label for accessibility
    if (semanticLabel != null) {
      result = Semantics(
        label: semanticLabel,
        textField: true,
        child: result,
      );
    }

    // Add label for Cupertino text field (Material handles this automatically)
    if (Platform.isIOS && label != null) {
      result = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                label!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          result,
          if (errorText.value != null) ...[
            const SizedBox(height: 8),
            Text(
              errorText.value!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
          if (helper != null && errorText.value == null) ...[
            const SizedBox(height: 8),
            Text(
              helper!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      );
    }

    return result;
  }
}
