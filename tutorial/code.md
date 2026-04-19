# Code

### 1. Red: Preserve The Prism Dimensions

Create the first code test file:

```bash
mkdir -p workspace/test/code
touch workspace/test/code/prism_net_layout_service_test.dart
just format
git add --all
git commit --message 'touch workspace/test/code/prism_net_layout_service_test.dart'
```

Put this exact content in `workspace/test/code/prism_net_layout_service_test.dart`:

```dart
import 'package:prism_net_layout/code/prism_net_layout_service.dart';
import 'package:test/test.dart';

void main() {
  test('buildPrismDimensions preserves width height and depth', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    expect(dimensions.width, 240);
    expect(dimensions.height, 360);
    expect(dimensions.depth, 90);
  });
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Preserve The Prism Dimensions"
```

### 2. Green: Preserve The Prism Dimensions

Create the first production file:

```bash
mkdir -p workspace/lib/code
touch workspace/lib/code/prism_net_layout_service.dart
just format
git add --all
git commit --message 'touch workspace/lib/code/prism_net_layout_service.dart'
```

Put this exact content in `workspace/lib/code/prism_net_layout_service.dart`:

```dart
import '../contracts/face_crop_plan.dart';
import '../contracts/face_size.dart';
import '../contracts/prism_dimensions.dart';
import '../contracts/prism_net_layout_item.dart';

const canonicalPrismFaces = [
  'front',
  'back',
  'left',
  'right',
  'top',
  'bottom',
];

PrismDimensions buildPrismDimensions({
  required int width,
  required int height,
  required int depth,
}) {
  return PrismDimensions(width: width, height: height, depth: depth);
}

FaceSize faceDisplaySize(String faceName, PrismDimensions dimensions) {
  throw UnimplementedError();
}

List<PrismNetLayoutItem> buildPrismNetLayout(
  List<FaceCropPlan> cropPlan,
  PrismDimensions dimensions,
) {
  throw UnimplementedError();
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Preserve The Prism Dimensions"
```

### 3. Red: Size The Canonical Faces

Replace `workspace/test/code/prism_net_layout_service_test.dart` with:

```dart
import 'package:prism_net_layout/code/prism_net_layout_service.dart';
import 'package:test/test.dart';

void main() {
  test('buildPrismDimensions preserves width height and depth', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    expect(dimensions.width, 240);
    expect(dimensions.height, 360);
    expect(dimensions.depth, 90);
  });

  test('faceDisplaySize returns width x height for front', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    final size = faceDisplaySize('front', dimensions);

    expect(size.width, 240);
    expect(size.height, 360);
  });

  test('faceDisplaySize returns depth x height for left', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    final size = faceDisplaySize('left', dimensions);

    expect(size.width, 90);
    expect(size.height, 360);
  });

  test('faceDisplaySize returns width x depth for top', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    final size = faceDisplaySize('top', dimensions);

    expect(size.width, 240);
    expect(size.height, 90);
  });
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Size The Canonical Faces"
```

### 4. Green: Size The Canonical Faces

Replace `workspace/lib/code/prism_net_layout_service.dart` with:

```dart
import '../contracts/face_crop_plan.dart';
import '../contracts/face_size.dart';
import '../contracts/prism_dimensions.dart';
import '../contracts/prism_net_layout_item.dart';

const canonicalPrismFaces = [
  'front',
  'back',
  'left',
  'right',
  'top',
  'bottom',
];

PrismDimensions buildPrismDimensions({
  required int width,
  required int height,
  required int depth,
}) {
  return PrismDimensions(width: width, height: height, depth: depth);
}

FaceSize faceDisplaySize(String faceName, PrismDimensions dimensions) {
  switch (faceName) {
    case 'front':
    case 'back':
      return FaceSize(width: dimensions.width, height: dimensions.height);
    case 'left':
    case 'right':
      return FaceSize(width: dimensions.depth, height: dimensions.height);
    case 'top':
    case 'bottom':
      return FaceSize(width: dimensions.width, height: dimensions.depth);
  }

  throw ArgumentError.value(faceName, 'faceName', 'Unknown face');
}

List<PrismNetLayoutItem> buildPrismNetLayout(
  List<FaceCropPlan> cropPlan,
  PrismDimensions dimensions,
) {
  throw UnimplementedError();
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Size The Canonical Faces"
```

### 5. Red: Build The Flat Prism Net

Replace `workspace/test/code/prism_net_layout_service_test.dart` with:

```dart
import 'package:prism_net_layout/code/prism_net_layout_service.dart';
import 'package:prism_net_layout/contracts/face_crop_plan.dart';
import 'package:test/test.dart';

void main() {
  test('buildPrismDimensions preserves width height and depth', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    expect(dimensions.width, 240);
    expect(dimensions.height, 360);
    expect(dimensions.depth, 90);
  });

  test('faceDisplaySize returns width x height for front', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    final size = faceDisplaySize('front', dimensions);

    expect(size.width, 240);
    expect(size.height, 360);
  });

  test('faceDisplaySize returns depth x height for left', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    final size = faceDisplaySize('left', dimensions);

    expect(size.width, 90);
    expect(size.height, 360);
  });

  test('faceDisplaySize returns width x depth for top', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    final size = faceDisplaySize('top', dimensions);

    expect(size.width, 240);
    expect(size.height, 90);
  });

  test('buildPrismNetLayout preserves canonical order and hides missing faces', () {
    final dimensions = buildPrismDimensions(
      width: 240,
      height: 360,
      depth: 90,
    );

    final layout = buildPrismNetLayout([
      const FaceCropPlan(
        faceName: 'front',
        pixelLeft: 30,
        pixelTop: 21,
        pixelWidth: 90,
        pixelHeight: 84,
        isMissing: false,
      ),
      const FaceCropPlan(
        faceName: 'back',
        pixelLeft: 0,
        pixelTop: 0,
        pixelWidth: 0,
        pixelHeight: 0,
        isMissing: true,
      ),
      const FaceCropPlan(
        faceName: 'left',
        pixelLeft: 0,
        pixelTop: 0,
        pixelWidth: 0,
        pixelHeight: 0,
        isMissing: true,
      ),
      const FaceCropPlan(
        faceName: 'right',
        pixelLeft: 135,
        pixelTop: 21,
        pixelWidth: 60,
        pixelHeight: 84,
        isMissing: false,
      ),
      const FaceCropPlan(
        faceName: 'top',
        pixelLeft: 30,
        pixelTop: 0,
        pixelWidth: 90,
        pixelHeight: 21,
        isMissing: false,
      ),
      const FaceCropPlan(
        faceName: 'bottom',
        pixelLeft: 0,
        pixelTop: 0,
        pixelWidth: 0,
        pixelHeight: 0,
        isMissing: true,
      ),
    ], dimensions);

    expect(
      layout.map((item) => item.faceName).toList(),
      ['front', 'back', 'left', 'right', 'top', 'bottom'],
    );

    final front = layout.firstWhere((item) => item.faceName == 'front');
    final left = layout.firstWhere((item) => item.faceName == 'left');
    final top = layout.firstWhere((item) => item.faceName == 'top');
    final bottom = layout.firstWhere((item) => item.faceName == 'bottom');

    expect(front.x, 90);
    expect(front.y, 90);
    expect(front.displayWidth, 240);
    expect(front.displayHeight, 360);
    expect(front.isHidden, isFalse);

    expect(left.x, 0);
    expect(left.y, 90);
    expect(left.displayWidth, 90);
    expect(left.displayHeight, 360);
    expect(left.isHidden, isTrue);

    expect(top.x, 90);
    expect(top.y, 0);
    expect(top.displayWidth, 240);
    expect(top.displayHeight, 90);
    expect(top.isHidden, isFalse);

    expect(bottom.isHidden, isTrue);
  });
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "5. Red: Build The Flat Prism Net"
```

### 6. Green: Build The Flat Prism Net

Replace `workspace/lib/code/prism_net_layout_service.dart` with:

```dart
import '../contracts/face_crop_plan.dart';
import '../contracts/face_size.dart';
import '../contracts/prism_dimensions.dart';
import '../contracts/prism_net_layout_item.dart';

const canonicalPrismFaces = [
  'front',
  'back',
  'left',
  'right',
  'top',
  'bottom',
];

PrismDimensions buildPrismDimensions({
  required int width,
  required int height,
  required int depth,
}) {
  return PrismDimensions(width: width, height: height, depth: depth);
}

FaceSize faceDisplaySize(String faceName, PrismDimensions dimensions) {
  switch (faceName) {
    case 'front':
    case 'back':
      return FaceSize(width: dimensions.width, height: dimensions.height);
    case 'left':
    case 'right':
      return FaceSize(width: dimensions.depth, height: dimensions.height);
    case 'top':
    case 'bottom':
      return FaceSize(width: dimensions.width, height: dimensions.depth);
  }

  throw ArgumentError.value(faceName, 'faceName', 'Unknown face');
}

List<PrismNetLayoutItem> buildPrismNetLayout(
  List<FaceCropPlan> cropPlan,
  PrismDimensions dimensions,
) {
  final cropPlanByFace = {
    for (final item in cropPlan) item.faceName: item,
  };

  final positions = <String, (int, int)>{
    'front': (dimensions.depth, dimensions.depth),
    'back': (dimensions.depth + dimensions.width + dimensions.depth, dimensions.depth),
    'left': (0, dimensions.depth),
    'right': (dimensions.depth + dimensions.width, dimensions.depth),
    'top': (dimensions.depth, 0),
    'bottom': (dimensions.depth, dimensions.depth + dimensions.height),
  };

  return canonicalPrismFaces.map((faceName) {
    final size = faceDisplaySize(faceName, dimensions);
    final (x, y) = positions[faceName]!;
    final crop = cropPlanByFace[faceName];

    return PrismNetLayoutItem(
      faceName: faceName,
      x: x,
      y: y,
      displayWidth: size.width,
      displayHeight: size.height,
      isHidden: crop?.isMissing ?? true,
    );
  }).toList();
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "6. Green: Build The Flat Prism Net"
```
