import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadget_store/view/dashboard_page.dart';

void main() {
  testWidgets('DashboardPage', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Dashboard(),
    ));

    await tester.pumpAndSettle();

    expect(find.text("DashboardPage "), findsOneWidget);

    await tester.pumpAndSettle();

    // var onlyTextField = find.byType(TextField).at(0);

    // expect(onlyTextField, findsOneWidget);
  });
}
