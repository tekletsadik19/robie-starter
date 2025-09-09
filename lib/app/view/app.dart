import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:shemanit/core/di/injection_container.dart';
import 'package:shemanit/core/theme/app_theme.dart';
import 'package:shemanit/core/theme/theme_cubit.dart';
import 'package:shemanit/features/counter/presentation/pages/counter_page.dart';
import 'package:shemanit/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Shemanit',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const CounterPage(),
            debugShowCheckedModeBanner: false,
            // Responsive and accessibility settings
            builder: (context, child) {
              return ResponsiveBreakpoints.builder(
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    // Ensure text scale factor is within reasonable bounds
                    textScaler: TextScaler.linear(
                      MediaQuery.of(context)
                          .textScaler
                          .scale(1)
                          .clamp(0.8, 2.0),
                    ),
                  ),
                  child: child!,
                ),
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(
                    start: 1921,
                    end: double.infinity,
                    name: '4K',
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
