import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medflow_/main.dart';

void main() {
  testWidgets('renders MedFlow splash flow', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MedFlowApp(),
      ),
    );

    expect(find.text('MedFlow'), findsOneWidget);
    expect(find.text('Operational intelligence for clinical teams'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();
  });
}
