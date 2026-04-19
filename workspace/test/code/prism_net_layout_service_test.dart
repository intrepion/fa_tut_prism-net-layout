import 'package:prism_net_layout/code/prism_net_layout_service.dart';
import 'package:test/test.dart';

void main() {
  test('buildPrismDimensions preserves width height and depth', () {
    final dimensions = buildPrismDimensions(width: 240, height: 360, depth: 90);

    expect(dimensions.width, 240);
    expect(dimensions.height, 360);
    expect(dimensions.depth, 90);
  });
}
