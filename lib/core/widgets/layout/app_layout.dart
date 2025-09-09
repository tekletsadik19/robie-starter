import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shemanit/core/responsive/responsive_utils.dart';
import 'package:shemanit/core/widgets/hooks/use_theme.dart';

/// Responsive layout wrapper with hooks
class AppLayout extends HookWidget {
  const AppLayout({
    required this.child,
    super.key,
    this.maxWidth,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.centerContent = false,
    this.safeArea = true,
    this.scrollable = false,
    this.semanticLabel,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final bool centerContent;
  final bool safeArea;
  final bool scrollable;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final screenSize = useScreenSize();
    useAccessibility();

    // Responsive calculations
    final effectiveMaxWidth = useMemoized(
      () {
        return maxWidth ?? ResponsiveUtils.getMaxContentWidth(context);
      },
      [maxWidth, screenSize],
    );

    final effectivePadding = useMemoized(
      () {
        return padding ?? ResponsiveUtils.responsivePadding(context);
      },
      [padding, screenSize],
    );

    final effectiveMargin = useMemoized(
      () {
        return margin ?? ResponsiveUtils.responsiveMargin(context);
      },
      [margin, screenSize],
    );

    Widget content = Container(
      width: double.infinity,
      margin: effectiveMargin,
      padding: effectivePadding,
      decoration: backgroundColor != null
          ? BoxDecoration(color: backgroundColor)
          : null,
      child: centerContent
          ? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
                child: child,
              ),
            )
          : ConstrainedBox(
              constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
              child: child,
            ),
    );

    // Add scrolling if requested
    if (scrollable) {
      content = SingleChildScrollView(
        child: content,
      );
    }

    // Add safe area if requested
    if (safeArea) {
      content = SafeArea(child: content);
    }

    // Add semantic label for accessibility
    if (semanticLabel != null) {
      content = Semantics(
        label: semanticLabel,
        child: content,
      );
    }

    return content;
  }
}

/// Grid layout with responsive columns
class AppGridLayout extends HookWidget {
  const AppGridLayout({
    required this.children,
    super.key,
    this.spacing = 16.0,
    this.runSpacing,
    this.childAspectRatio = 1.0,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.maxCrossAxisExtent,
    this.semanticLabel,
  });

  final List<Widget> children;
  final double spacing;
  final double? runSpacing;
  final double childAspectRatio;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double? maxCrossAxisExtent;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final screenSize = useScreenSize();

    // Calculate responsive columns
    final columns = useMemoized(
      () {
        if (screenSize.isDesktop) return desktopColumns;
        if (screenSize.isTablet) return tabletColumns;
        return mobileColumns;
      },
      [screenSize],
    );

    final effectiveRunSpacing = runSpacing ?? spacing;
    final screenWidth = MediaQuery.of(context).size.width;
    final totalSpacing = spacing * (columns - 1);
    final availableWidth = screenWidth - totalSpacing;
    final itemWidth = availableWidth / columns;

    return Semantics(
      label: semanticLabel ?? 'Grid layout with ${children.length} items',
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent ?? itemWidth,
          mainAxisSpacing: effectiveRunSpacing,
          crossAxisSpacing: spacing,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}

/// Stack layout with responsive positioning
class AppStackLayout extends HookWidget {
  const AppStackLayout({
    required this.children,
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
    this.semanticLabel,
  });

  final List<Widget> children;
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit fit;
  final Clip clipBehavior;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? 'Layered content',
      child: Stack(
        alignment: alignment,
        textDirection: textDirection,
        fit: fit,
        clipBehavior: clipBehavior,
        children: children,
      ),
    );
  }
}

/// Section layout with title and optional actions
class AppSection extends HookWidget {
  const AppSection({
    required this.title,
    required this.child,
    super.key,
    this.subtitle,
    this.actions,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.showDivider = false,
    this.semanticLabel,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool showDivider;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final textTheme = useTextTheme();
    useAccessibility();

    final effectivePadding = useMemoized(
      () {
        return padding ?? ResponsiveUtils.responsivePadding(context);
      },
      [padding],
    );

    return Semantics(
      label: semanticLabel ?? 'Section: $title',
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: effectivePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          semanticsLabel: 'Section title: $title',
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: textTheme.bodyMedium?.copyWith(
                              color: theme.isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                            semanticsLabel: 'Section subtitle: $subtitle',
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (actions != null) ...[
                    const SizedBox(width: 16),
                    Row(children: actions!),
                  ],
                ],
              ),

              if (showDivider) ...[
                const SizedBox(height: 16),
                const Divider(),
              ],

              const SizedBox(height: 16),

              // Content
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Flex layout with responsive direction
class AppFlexLayout extends HookWidget {
  const AppFlexLayout({
    required this.children,
    super.key,
    this.direction = Axis.horizontal,
    this.mobileDirection,
    this.tabletDirection,
    this.desktopDirection,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 0.0,
    this.wrap = false,
    this.semanticLabel,
  });

  final List<Widget> children;
  final Axis direction;
  final Axis? mobileDirection;
  final Axis? tabletDirection;
  final Axis? desktopDirection;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;
  final bool wrap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final screenSize = useScreenSize();

    // Calculate responsive direction
    final effectiveDirection = useMemoized(
      () {
        if (screenSize.isDesktop && desktopDirection != null) {
          return desktopDirection!;
        }
        if (screenSize.isTablet && tabletDirection != null) {
          return tabletDirection!;
        }
        if (screenSize.isMobile && mobileDirection != null) {
          return mobileDirection!;
        }
        return direction;
      },
      [
        screenSize,
        direction,
        mobileDirection,
        tabletDirection,
        desktopDirection,
      ],
    );

    // Add spacing between children
    final spacedChildren = useMemoized(
      () {
        if (spacing == 0 || children.isEmpty) return children;

        final result = <Widget>[];
        for (var i = 0; i < children.length; i++) {
          result.add(children[i]);
          if (i < children.length - 1) {
            result.add(
              SizedBox(
                width: effectiveDirection == Axis.horizontal ? spacing : 0,
                height: effectiveDirection == Axis.vertical ? spacing : 0,
              ),
            );
          }
        }
        return result;
      },
      [children, spacing, effectiveDirection],
    );

    Widget flexWidget = effectiveDirection == Axis.horizontal
        ? Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: spacedChildren,
          )
        : Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: spacedChildren,
          );

    // Add wrapping if requested
    if (wrap && effectiveDirection == Axis.horizontal) {
      flexWidget = Wrap(
        direction: effectiveDirection,
        spacing: spacing,
        runSpacing: spacing,
        children: children, // Use original children without added spacing
      );
    }

    return Semantics(
      label: semanticLabel ?? 'Flexible layout',
      child: flexWidget,
    );
  }
}
