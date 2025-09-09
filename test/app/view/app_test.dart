import 'package:flutter_test/flutter_test.dart';
import 'package:robbie_starter/app/app.dart';
import 'package:robbie_starter/app/view/main_navigation.dart';

void main() {
  group('App', () {
    testWidgets('renders MainNavigation', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MainNavigation), findsOneWidget);
    });
  });
}
