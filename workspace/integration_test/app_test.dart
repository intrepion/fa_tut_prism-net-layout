import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:prism_net_layout/adapter/prism_net_layout_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders the prism net layout title', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PrismNetLayoutPage()));
    await tester.pumpAndSettle();

    expect(find.text('Prism Net Layout'), findsOneWidget);
  });
}
