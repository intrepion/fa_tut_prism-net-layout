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
  throw UnimplementedError();
}
