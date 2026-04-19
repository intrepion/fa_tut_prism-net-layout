import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prism_net_layout/adapter/prism_net_layout_page.dart';

void main() {
  testWidgets('renders a flat prism net from the core-generated layout', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PrismNetLayoutPage()));
    await tester.pumpAndSettle();

    expect(find.text('240 x 360 x 90'), findsOneWidget);
    expect(find.byKey(const Key('net-front')), findsOneWidget);
    expect(find.byKey(const Key('net-right')), findsOneWidget);
    expect(find.byKey(const Key('net-top')), findsOneWidget);
    expect(find.byKey(const Key('net-left')), findsNothing);
    expect(find.byKey(const Key('net-bottom')), findsNothing);
  });
}
