import 'package:flutter_test/flutter_test.dart';
import 'package:robbie_starter/app/app.dart';
import 'package:robbie_starter/features/counter/presentation/pages/counter_page.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
