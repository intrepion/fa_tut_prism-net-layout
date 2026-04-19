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
  throw UnimplementedError();
}

List<PrismNetLayoutItem> buildPrismNetLayout(
  List<FaceCropPlan> cropPlan,
  PrismDimensions dimensions,
) {
  throw UnimplementedError();
}
