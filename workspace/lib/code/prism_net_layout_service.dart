import '../contracts/face_crop_plan.dart';
import '../contracts/face_size.dart';
import '../contracts/prism_dimensions.dart';
import '../contracts/prism_net_layout_item.dart';

const canonicalPrismFaces = ['front', 'back', 'left', 'right', 'top', 'bottom'];

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
  final cropPlanByFace = {for (final item in cropPlan) item.faceName: item};

  final positions = <String, (int, int)>{
    'front': (dimensions.depth, dimensions.depth),
    'back': (
      dimensions.depth + dimensions.width + dimensions.depth,
      dimensions.depth,
    ),
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
