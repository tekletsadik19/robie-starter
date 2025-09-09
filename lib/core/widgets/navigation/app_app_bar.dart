import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robbie_starter/core/accessibility/accessibility_utils.dart';
import 'package:robbie_starter/core/responsive/responsive_utils.dart';
import 'package:robbie_starter/core/theme/theme_cubit.dart';

/// Platform-adaptive app bar with theme switching
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.showThemeToggle = false,
    this.semanticLabel,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool showThemeToggle;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    // Use platform-specific app bar on iOS
    if (Platform.isIOS) {
      return _buildCupertinoAppBar(context);
    }

    // Use Material app bar for all other platforms
    return _buildMaterialAppBar(context);
  }

  Widget _buildCupertinoAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActions = _buildEffectiveActions(context);

    return Semantics(
      label: semanticLabel ?? 'App bar',
      header: true,
      child: CupertinoNavigationBar(
        leading: leading,
        middle: title,
        trailing: effectiveActions.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: effectiveActions,
              )
            : null,
        backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialAppBar(BuildContext context) {
    final effectiveActions = _buildEffectiveActions(context);

    return Semantics(
      label: semanticLabel ?? 'App bar',
      header: true,
      child: AppBar(
        title: title,
        leading: leading,
        actions: effectiveActions,
        centerTitle: centerTitle,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
      ),
    );
  }

  List<Widget> _buildEffectiveActions(BuildContext context) {
    final actionsList = <Widget>[];

    // Add custom actions first
    if (actions != null) {
      actionsList.addAll(actions!);
    }

    // Add theme toggle if requested
    if (showThemeToggle) {
      actionsList.add(_buildThemeToggle(context));
    }

    return actionsList;
  }

  Widget _buildThemeToggle(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeCubit = context.read<ThemeCubit>();
        final isDark = themeCubit.isDarkMode;

        if (Platform.isIOS) {
          return CupertinoButton(
            padding: const EdgeInsets.all(8),
            onPressed: themeCubit.toggleTheme,
            child: Icon(
              isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon,
              semanticLabel: AccessibilityUtils.createButtonLabel(
                label:
                    isDark ? 'Switch to light theme' : 'Switch to dark theme',
              ),
            ),
          );
        }

        return IconButton(
          onPressed: themeCubit.toggleTheme,
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          tooltip: isDark ? 'Switch to light theme' : 'Switch to dark theme',
        );
      },
    );
  }

  @override
  Size get preferredSize {
    if (Platform.isIOS) {
      return const Size.fromHeight(44); // Standard iOS navigation bar height
    }
    return const Size.fromHeight(
      kToolbarHeight,
    ); // Standard Material app bar height
  }
}

/// Responsive app bar that adapts to screen size
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showThemeToggle = false,
    this.semanticLabel,
    this.onMenuPressed,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showThemeToggle;
  final String? semanticLabel;
  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return AppAppBar(
      title: title,
      leading: leading ??
          (isMobile && onMenuPressed != null
              ? _buildMenuButton(context)
              : null),
      actions: _buildResponsiveActions(context),
      showThemeToggle: showThemeToggle,
      semanticLabel: semanticLabel,
      centerTitle: isMobile,
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        padding: const EdgeInsets.all(8),
        onPressed: onMenuPressed,
        child: Icon(
          CupertinoIcons.bars,
          semanticLabel: AccessibilityUtils.createButtonLabel(
            label: 'Open navigation menu',
          ),
        ),
      );
    }

    return IconButton(
      onPressed: onMenuPressed,
      icon: const Icon(Icons.menu),
      tooltip: 'Open navigation menu',
    );
  }

  List<Widget> _buildResponsiveActions(BuildContext context) {
    final actionsList = <Widget>[];
    final isDesktop = ResponsiveUtils.isDesktop(context);

    // Add custom actions
    if (actions != null) {
      if (isDesktop) {
        // Show all actions on desktop
        actionsList.addAll(actions!);
      } else {
        // Show limited actions on mobile, rest in overflow menu
        final visibleActions = actions!.take(2).toList();
        actionsList.addAll(visibleActions);

        if (actions!.length > 2) {
          actionsList.add(_buildOverflowMenu(context));
        }
      }
    }

    return actionsList;
  }

  Widget _buildOverflowMenu(BuildContext context) {
    final remainingActions = actions!.skip(2).toList();

    if (Platform.isIOS) {
      return CupertinoButton(
        padding: const EdgeInsets.all(8),
        onPressed: () => _showCupertinoActionSheet(context, remainingActions),
        child: Icon(
          CupertinoIcons.ellipsis,
          semanticLabel: AccessibilityUtils.createButtonLabel(
            label: 'More actions',
          ),
        ),
      );
    }

    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert),
      tooltip: 'More actions',
      itemBuilder: (context) => remainingActions
          .asMap()
          .entries
          .map(
            (entry) => PopupMenuItem<int>(
              value: entry.key,
              child: entry.value,
            ),
          )
          .toList(),
      onSelected: (index) {
        // Handle action selection
      },
    );
  }

  void _showCupertinoActionSheet(BuildContext context, List<Widget> actions) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: actions
            .map(
              (action) => CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: action,
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    if (Platform.isIOS) {
      return const Size.fromHeight(44);
    }
    return const Size.fromHeight(kToolbarHeight);
  }
}
