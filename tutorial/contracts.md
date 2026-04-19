# Contracts

Create the shared contract files:

```bash
mkdir -p workspace/lib/contracts
touch workspace/lib/contracts/face_crop_plan.dart
just format
git add --all
git commit --message 'touch workspace/lib/contracts/face_crop_plan.dart'
touch workspace/lib/contracts/prism_dimensions.dart
just format
git add --all
git commit --message 'touch workspace/lib/contracts/prism_dimensions.dart'
touch workspace/lib/contracts/face_size.dart
just format
git add --all
git commit --message 'touch workspace/lib/contracts/face_size.dart'
touch workspace/lib/contracts/prism_net_layout_item.dart
just format
git add --all
git commit --message 'touch workspace/lib/contracts/prism_net_layout_item.dart'
```

Put this exact content in `workspace/lib/contracts/face_crop_plan.dart`:

```dart
class FaceCropPlan {
  final String faceName;
  final int pixelLeft;
  final int pixelTop;
  final int pixelWidth;
  final int pixelHeight;
  final bool isMissing;

  const FaceCropPlan({
    required this.faceName,
    required this.pixelLeft,
    required this.pixelTop,
    required this.pixelWidth,
    required this.pixelHeight,
    required this.isMissing,
  });
}
```

Put this exact content in `workspace/lib/contracts/prism_dimensions.dart`:

```dart
class PrismDimensions {
  final int width;
  final int height;
  final int depth;

  const PrismDimensions({
    required this.width,
    required this.height,
    required this.depth,
  });
}
```

Put this exact content in `workspace/lib/contracts/face_size.dart`:

```dart
class FaceSize {
  final int width;
  final int height;

  const FaceSize({
    required this.width,
    required this.height,
  });
}
```

Put this exact content in `workspace/lib/contracts/prism_net_layout_item.dart`:

```dart
class PrismNetLayoutItem {
  final String faceName;
  final int x;
  final int y;
  final int displayWidth;
  final int displayHeight;
  final bool isHidden;

  const PrismNetLayoutItem({
    required this.faceName,
    required this.x,
    required this.y,
    required this.displayWidth,
    required this.displayHeight,
    required this.isHidden,
  });
}
```

Do not add tests here. Keep this layer limited to interfaces and small shared types.

Then run:

```bash
just format
just check-all
git add --all
git commit --message "Define prism-net-layout Flutter contracts"
```
