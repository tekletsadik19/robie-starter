import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_cubit.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required ThemeMode themeMode,
    @Default(false) bool isSystemTheme,
  }) = _ThemeState;
}

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._prefs)
      : super(
          const ThemeState(
            themeMode: ThemeMode.system,
            isSystemTheme: true,
          ),
        ) {
    _loadTheme();
  }

  final SharedPreferences _prefs;
  static const _themeKey = 'app_theme_mode';

  void _loadTheme() {
    final savedTheme = _prefs.getString(_themeKey);
    final themeMode = switch (savedTheme) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    emit(
      ThemeState(
        themeMode: themeMode,
        isSystemTheme: themeMode == ThemeMode.system,
      ),
    );
  }

  Future<void> setLightTheme() async {
    await _prefs.setString(_themeKey, 'light');
    emit(const ThemeState(themeMode: ThemeMode.light));
  }

  Future<void> setDarkTheme() async {
    await _prefs.setString(_themeKey, 'dark');
    emit(const ThemeState(themeMode: ThemeMode.dark));
  }

  Future<void> setSystemTheme() async {
    await _prefs.setString(_themeKey, 'system');
    emit(const ThemeState(themeMode: ThemeMode.system, isSystemTheme: true));
  }

  Future<void> toggleTheme() async {
    switch (state.themeMode) {
      case ThemeMode.light:
        await setDarkTheme();
      case ThemeMode.dark:
        await setSystemTheme();
      case ThemeMode.system:
        await setLightTheme();
    }
  }

  bool get isDarkMode {
    return state.themeMode == ThemeMode.dark ||
        (state.themeMode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);
  }

  bool get isLightMode {
    return state.themeMode == ThemeMode.light ||
        (state.themeMode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.light);
  }
}
