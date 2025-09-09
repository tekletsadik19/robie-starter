import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:robbie_starter/core/responsive/responsive_utils.dart';
import 'package:robbie_starter/core/widgets/hooks/use_theme.dart';

/// Navigation drawer item data class
class AppNavigationItem {
  const AppNavigationItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.onTap,
    this.badge,
    this.semanticLabel,
  });

  final String label;
  final Widget icon;
  final Widget? selectedIcon;
  final VoidCallback? onTap;
  final Widget? badge;
  final String? semanticLabel;
}

/// Responsive navigation drawer with hooks
class AppNavigationDrawer extends HookWidget {
  const AppNavigationDrawer({
    required this.items,
    super.key,
    this.selectedIndex = 0,
    this.onItemSelected,
    this.header,
    this.footer,
    this.backgroundColor,
    this.surfaceTintColor,
    this.shadowColor,
    this.elevation,
    this.semanticLabel,
    this.width,
  });

  final List<AppNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;
  final Widget? header;
  final Widget? footer;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final Color? shadowColor;
  final double? elevation;
  final String? semanticLabel;
  final double? width;

  @override
  Widget build(BuildContext context) {
    useTheme();
    final colorScheme = useColorScheme();
    final screenSize = useScreenSize();

    // State for drawer interactions
    final selectedIndexState = useState(selectedIndex);
    final isHoveredIndex = useState<int?>(null);

    // Animation controller for item transitions
    useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    // Update selected index when prop changes
    useEffect(
      () {
        selectedIndexState.value = selectedIndex;
        return null;
      },
      [selectedIndex],
    );

    // Responsive width calculation
    final effectiveWidth = useMemoized(
      () {
        if (width != null) return width!;

        return ResponsiveUtils.responsiveValue(
          context: context,
          mobile: 280,
          tablet: 320,
          desktop: 360,
        );
      },
      [width, screenSize],
    );

    return Semantics(
      label: semanticLabel ?? 'Navigation drawer',
      child: SizedBox(
        width: effectiveWidth as double?,
        child: NavigationDrawer(
          backgroundColor: backgroundColor ?? colorScheme.surface,
          surfaceTintColor: surfaceTintColor,
          shadowColor: shadowColor,
          elevation: elevation,
          children: [
            // Header
            if (header != null) header!,

            // Navigation items
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == selectedIndexState.value;
              final isHovered = index == isHoveredIndex.value;

              return _buildNavigationItem(
                context,
                item,
                index,
                isSelected,
                isHovered,
                colorScheme,
                () {
                  selectedIndexState.value = index;
                  onItemSelected?.call(index);
                  item.onTap?.call();
                },
                (hovered) {
                  isHoveredIndex.value = hovered ? index : null;
                },
              );
            }),

            // Footer
            if (footer != null) ...[
              const Divider(),
              footer!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItem(
    BuildContext context,
    AppNavigationItem item,
    int index,
    bool isSelected,
    bool isHovered,
    ColorScheme colorScheme,
    VoidCallback onTap,
    ValueChanged<bool> onHover,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: MouseRegion(
        onEnter: (_) => onHover(true),
        onExit: (_) => onHover(false),
        child: ListTile(
          leading: isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
          title: Text(item.label),
          trailing: item.badge,
          selected: isSelected,
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          enableFeedback: true,
          // Custom styling based on state
          tileColor: isSelected
              ? colorScheme.secondaryContainer.withValues(alpha: 0.3)
              : isHovered
                  ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                  : null,
          textColor: isSelected
              ? colorScheme.onSecondaryContainer
              : colorScheme.onSurface,
          iconColor: isSelected
              ? colorScheme.onSecondaryContainer
              : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Rail navigation for tablet/desktop layouts
class AppNavigationRail extends HookWidget {
  const AppNavigationRail({
    required this.items,
    super.key,
    this.selectedIndex = 0,
    this.onItemSelected,
    this.extended = false,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.minWidth = 72.0,
    this.minExtendedWidth = 256.0,
  });

  final List<AppNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;
  final bool extended;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final double? elevation;
  final String? semanticLabel;
  final double minWidth;
  final double minExtendedWidth;

  @override
  Widget build(BuildContext context) {
    final colorScheme = useColorScheme();
    final accessibility = useAccessibility();

    // State management
    final selectedIndexState = useState(selectedIndex);
    final extendedState = useState(extended);

    // Animation for rail extension
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final widthAnimation = useAnimation(
      Tween<double>(
        begin: minWidth,
        end: minExtendedWidth,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
    );

    // Handle extension state changes
    useEffect(
      () {
        if (extendedState.value) {
          animationController.forward();
        } else {
          animationController.reverse();
        }
        return null;
      },
      [extendedState.value],
    );

    // Update selected index when prop changes
    useEffect(
      () {
        selectedIndexState.value = selectedIndex;
        return null;
      },
      [selectedIndex],
    );

    // Convert items to NavigationRailDestination
    final destinations = useMemoized(
      () {
        return items
            .map(
              (item) => NavigationRailDestination(
                icon: item.icon,
                selectedIcon: item.selectedIcon ?? item.icon,
                label: Text(item.label),
              ),
            )
            .toList();
      },
      [items],
    );

    return Semantics(
      label: semanticLabel ?? 'Navigation rail',
      child: SizedBox(
        width: widthAnimation,
        child: NavigationRail(
          selectedIndex: selectedIndexState.value,
          onDestinationSelected: (index) {
            selectedIndexState.value = index;
            onItemSelected?.call(index);
            if (index < items.length) {
              items[index].onTap?.call();
            }
          },
          extended: extendedState.value,
          leading: leading,
          trailing: Column(
            children: [
              if (trailing != null) trailing!,
              // Toggle button for extension
              IconButton(
                onPressed: () => extendedState.value = !extendedState.value,
                icon: Icon(
                  extendedState.value
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                ),
                tooltip: extendedState.value ? 'Collapse' : 'Expand',
              ),
            ],
          ),
          destinations: destinations,
          backgroundColor: backgroundColor ?? colorScheme.surface,
          elevation: elevation,
          minWidth: minWidth,
          minExtendedWidth: minExtendedWidth,
          // Accessibility enhancements
          labelType: accessibility.isScreenReaderEnabled
              ? NavigationRailLabelType.all
              : extendedState.value
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.selected,
        ),
      ),
    );
  }
}

/// Adaptive navigation that switches between drawer/rail based on screen size
class AppAdaptiveNavigation extends HookWidget {
  const AppAdaptiveNavigation({
    required this.items,
    required this.child,
    super.key,
    this.selectedIndex = 0,
    this.onItemSelected,
    this.drawerHeader,
    this.drawerFooter,
    this.railLeading,
    this.railTrailing,
    this.semanticLabel,
  });

  final List<AppNavigationItem> items;
  final Widget child;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;
  final Widget? drawerHeader;
  final Widget? drawerFooter;
  final Widget? railLeading;
  final Widget? railTrailing;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final screenSize = useScreenSize();
    final drawerKey = useMemoized(GlobalKey<ScaffoldState>.new, []);

    // Show drawer on mobile, rail on larger screens
    if (screenSize.isMobile) {
      return Scaffold(
        key: drawerKey,
        drawer: AppNavigationDrawer(
          items: items,
          selectedIndex: selectedIndex,
          onItemSelected: onItemSelected,
          header: drawerHeader,
          footer: drawerFooter,
          semanticLabel: semanticLabel,
        ),
        body: child,
      );
    }

    // Rail navigation for tablet/desktop
    return Scaffold(
      body: Row(
        children: [
          AppNavigationRail(
            items: items,
            selectedIndex: selectedIndex,
            onItemSelected: onItemSelected,
            extended: screenSize.isDesktop,
            leading: railLeading,
            trailing: railTrailing,
            semanticLabel: semanticLabel,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
