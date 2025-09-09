import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shemanit/l10n/arb/app_localizations.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) => pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      );
}
