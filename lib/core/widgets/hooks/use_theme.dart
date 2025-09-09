import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shemanit/core/theme/theme_cubit.dart';

/// Hook for accessing and managing theme state
({
  ThemeData lightTheme,
  ThemeData darkTheme,
  ThemeMode themeMode,
  bool isDark,
  bool isLight,
  bool isSystem,
  void Function() toggleTheme,
  void Function() setLightTheme,
  void Function() setDarkTheme,
  void Function() setSystemTheme,
}) useTheme() {
  final context = useContext();
  final themeCubit = context.read<ThemeCubit>();
  final themeState = useBlocBuilder<ThemeCubit, ThemeState>(themeCubit);

  final lightTheme = useMemoized(() => Theme.of(context), []);
  final darkTheme = useMemoized(ThemeData.dark, []);

  final toggleTheme = useCallback(themeCubit.toggleTheme, []);
  final setLightTheme = useCallback(themeCubit.setLightTheme, []);
  final setDarkTheme = useCallback(themeCubit.setDarkTheme, []);
  final setSystemTheme = useCallback(themeCubit.setSystemTheme, []);

  return (
    lightTheme: lightTheme,
    darkTheme: darkTheme,
    themeMode: themeState.themeMode,
    isDark: themeCubit.isDarkMode,
    isLight: themeCubit.isLightMode,
    isSystem: themeState.isSystemTheme,
    toggleTheme: toggleTheme,
    setLightTheme: setLightTheme,
    setDarkTheme: setDarkTheme,
    setSystemTheme: setSystemTheme,
  );
}

/// Hook for responsive design values
T useResponsive<T>(
  BuildContext context, {
  required T mobile,
  T? tablet,
  T? desktop,
}) {
  final mediaQuery = MediaQuery.of(context);

  return useMemoized(
    () {
      final width = mediaQuery.size.width;

      if (width >= 1024 && desktop != null) return desktop;
      if (width >= 768 && tablet != null) return tablet;
      return mobile;
    },
    [mediaQuery.size.width, mobile, tablet, desktop],
  );
}

/// Hook for accessing current color scheme
ColorScheme useColorScheme() {
  final context = useContext();
  return Theme.of(context).colorScheme;
}

/// Hook for accessing current text theme
TextTheme useTextTheme() {
  final context = useContext();
  return Theme.of(context).textTheme;
}

/// Hook for platform brightness detection
Brightness usePlatformBrightness() {
  final brightness = useState(Brightness.light);

  useEffect(
    () {
      void updateBrightness() {
        final platformBrightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        brightness.value = platformBrightness;
      }

      updateBrightness();

      // Listen to platform brightness changes
      WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
          updateBrightness;

      return () {
        WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
            null;
      };
    },
    [],
  );

  return brightness.value;
}

/// Hook for safe area insets
EdgeInsets useSafeAreaInsets() {
  final context = useContext();
  return MediaQuery.of(context).padding;
}

/// Hook for screen size categories
({
  bool isMobile,
  bool isTablet,
  bool isDesktop,
  bool isLandscape,
  bool isPortrait
}) useScreenSize() {
  final context = useContext();
  final mediaQuery = MediaQuery.of(context);

  return useMemoized(
    () {
      final width = mediaQuery.size.width;
      final orientation = mediaQuery.orientation;

      return (
        isMobile: width < 768,
        isTablet: width >= 768 && width < 1024,
        isDesktop: width >= 1024,
        isLandscape: orientation == Orientation.landscape,
        isPortrait: orientation == Orientation.portrait,
      );
    },
    [mediaQuery.size.width, mediaQuery.orientation],
  );
}

/// Hook for dynamic color generation
Color useDynamicColor(Color baseColor, {double lightnessFactor = 0.1}) {
  final isDark = useTheme().isDark;

  return useMemoized(
    () {
      if (isDark) {
        // Make color lighter for dark theme
        final hsl = HSLColor.fromColor(baseColor);
        return hsl
            .withLightness(
              (hsl.lightness + lightnessFactor).clamp(0.0, 1.0),
            )
            .toColor();
      } else {
        // Make color darker for light theme
        final hsl = HSLColor.fromColor(baseColor);
        return hsl
            .withLightness(
              (hsl.lightness - lightnessFactor).clamp(0.0, 1.0),
            )
            .toColor();
      }
    },
    [baseColor, isDark, lightnessFactor],
  );
}

/// Hook for accessibility settings
({
  bool isScreenReaderEnabled,
  bool isHighContrastEnabled,
  bool isBoldTextEnabled,
  double textScaleFactor,
  bool reduceMotion,
}) useAccessibility() {
  final context = useContext();
  final mediaQuery = MediaQuery.of(context);

  return useMemoized(
      () => (
            isScreenReaderEnabled: mediaQuery.accessibleNavigation,
            isHighContrastEnabled: mediaQuery.highContrast,
            isBoldTextEnabled: mediaQuery.boldText,
            textScaleFactor: mediaQuery.textScaler.scale(1),
            reduceMotion: mediaQuery.disableAnimations,
          ),
      [
        mediaQuery.accessibleNavigation,
        mediaQuery.highContrast,
        mediaQuery.boldText,
        mediaQuery.textScaler.scale(1),
        mediaQuery.disableAnimations,
      ]);
}

/// Hook for adaptive padding based on screen size
EdgeInsets useAdaptivePadding(
  BuildContext context, {
  double mobile = 16.0,
  double tablet = 24.0,
  double desktop = 32.0,
}) {
  return useResponsive<EdgeInsets>(
    context,
    mobile: EdgeInsets.all(mobile),
    tablet: EdgeInsets.all(tablet),
    desktop: EdgeInsets.all(desktop),
  );
}

/// Hook for adaptive margin based on screen size
EdgeInsets useAdaptiveMargin(
  BuildContext context, {
  double mobile = 8.0,
  double tablet = 16.0,
  double desktop = 24.0,
}) {
  return useResponsive<EdgeInsets>(
    context,
    mobile: EdgeInsets.all(mobile),
    tablet: EdgeInsets.all(tablet),
    desktop: EdgeInsets.all(desktop),
  );
}

/// Hook for adaptive font size
double useAdaptiveFontSize(double baseFontSize, {double scaleFactor = 0.1}) {
  final screenSize = useScreenSize();

  return useMemoized(
    () {
      if (screenSize.isDesktop) {
        return baseFontSize + (baseFontSize * scaleFactor);
      } else if (screenSize.isTablet) {
        return baseFontSize + (baseFontSize * scaleFactor * 0.5);
      } else {
        return baseFontSize - (baseFontSize * scaleFactor * 0.2);
      }
    },
    [baseFontSize, scaleFactor, screenSize],
  );
}

/// Hook for BLoC state management integration with hooks
S useBlocBuilder<B extends StateStreamable<S>, S>(B bloc) {
  final state = useState<S>(bloc.state);

  useEffect(
    () {
      final subscription = bloc.stream.listen((newState) {
        state.value = newState;
      });

      return subscription.cancel;
    },
    [bloc],
  );

  return state.value;
}
