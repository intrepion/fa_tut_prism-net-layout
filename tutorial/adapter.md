# Adapter

### 1. Red: Add The Prism Net Layout Page Widget Test

Create the widget test file:

```bash
mkdir -p workspace/test/adapter
touch workspace/test/adapter/prism_net_layout_page_test.dart
just format
git add --all
git commit --message 'touch workspace/test/adapter/prism_net_layout_page_test.dart'
```

Put this exact content in `workspace/test/adapter/prism_net_layout_page_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prism_net_layout/adapter/prism_net_layout_page.dart';

void main() {
  testWidgets('renders a flat prism net from the core-generated layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: PrismNetLayoutPage()),
    );
    await tester.pumpAndSettle();

    expect(find.text('240 x 360 x 90'), findsOneWidget);
    expect(find.byKey(const Key('net-front')), findsOneWidget);
    expect(find.byKey(const Key('net-right')), findsOneWidget);
    expect(find.byKey(const Key('net-top')), findsOneWidget);
    expect(find.byKey(const Key('net-left')), findsNothing);
    expect(find.byKey(const Key('net-bottom')), findsNothing);
  });
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Add The Prism Net Layout Page Widget Test"
```

### 2. Green: Build The Prism Net Layout Page

Create the page production file:

```bash
mkdir -p workspace/lib/adapter
touch workspace/lib/adapter/prism_net_layout_page.dart
just format
git add --all
git commit --message 'touch workspace/lib/adapter/prism_net_layout_page.dart'
```

Put this exact content in `workspace/lib/adapter/prism_net_layout_page.dart`:

```dart
import 'package:flutter/material.dart';

import '../code/prism_net_layout_service.dart';
import '../contracts/face_crop_plan.dart';

class PrismNetLayoutPage extends StatelessWidget {
  const PrismNetLayoutPage({super.key});

  List<FaceCropPlan> _demoCropPlan() {
    return const [
      FaceCropPlan(
        faceName: 'front',
        pixelLeft: 30,
        pixelTop: 21,
        pixelWidth: 90,
        pixelHeight: 84,
        isMissing: false,
      ),
      FaceCropPlan(
        faceName: 'back',
        pixelLeft: 0,
        pixelTop: 0,
        pixelWidth: 0,
        pixelHeight: 0,
        isMissing: true,
      ),
      FaceCropPlan(
        faceName: 'left',
        pixelLeft: 0,
        pixelTop: 0,
        pixelWidth: 0,
        pixelHeight: 0,
        isMissing: true,
      ),
      FaceCropPlan(
        faceName: 'right',
        pixelLeft: 135,
        pixelTop: 21,
        pixelWidth: 60,
        pixelHeight: 84,
        isMissing: false,
      ),
      FaceCropPlan(
        faceName: 'top',
        pixelLeft: 30,
        pixelTop: 0,
        pixelWidth: 90,
        pixelHeight: 21,
        isMissing: false,
      ),
      FaceCropPlan(
        faceName: 'bottom',
        pixelLeft: 0,
        pixelTop: 0,
        pixelWidth: 0,
        pixelHeight: 0,
        isMissing: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );
    final layout = buildPrismNetLayout(_demoCropPlan(), dimensions);
    const netWidth = 660.0;
    const netHeight = 450.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Prism Net Layout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${dimensions.width} x ${dimensions.height} x ${dimensions.depth}',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                color: const Color(0xFFF7F1E1),
                child: FittedBox(
                  alignment: Alignment.topLeft,
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: netWidth,
                    height: netHeight,
                    child: Stack(
                      children: [
                        for (final item in layout)
                          if (!item.isHidden)
                            Positioned(
                              left: item.x.toDouble(),
                              top: item.y.toDouble(),
                              child: _NetFacePanel(
                                key: Key('net-${item.faceName}'),
                                faceName: item.faceName,
                                width: item.displayWidth.toDouble(),
                                height: item.displayHeight.toDouble(),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NetFacePanel extends StatelessWidget {
  final String faceName;
  final double width;
  final double height;

  const _NetFacePanel({
    super.key,
    required this.faceName,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFDDC48E),
        border: Border.all(color: Colors.brown, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(faceName),
    );
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Build The Prism Net Layout Page"
```

### 3. Red: Add The Integration Test

Create the integration test file:

```bash
mkdir -p workspace/integration_test
touch workspace/integration_test/app_test.dart
just format
git add --all
git commit --message 'touch workspace/integration_test/app_test.dart'
```

Put this exact content in `workspace/integration_test/app_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:prism_net_layout/adapter/prism_net_layout_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders the prism net layout title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: PrismNetLayoutPage()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Prism Net Layout'), findsOneWidget);
  });
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Add The Integration Test"
```

### 4. Green: Wire The Real Application

Replace `workspace/lib/main.dart` with:

```dart
import 'package:flutter/material.dart';

import 'adapter/prism_net_layout_page.dart';

void main() {
  runApp(const PrismNetLayoutApp());
}

class PrismNetLayoutApp extends StatelessWidget {
  const PrismNetLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Prism Net Layout',
      home: PrismNetLayoutPage(),
    );
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Wire The Real Application"
```
