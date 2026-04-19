import 'package:prism_net_layout/code/prism_net_layout_service.dart';
import 'package:test/test.dart';

void main() {
  test('buildPrismDimensions preserves width height and depth', () {
    final dimensions = buildPrismDimensions(width: 240, height: 360, depth: 90);

    expect(dimensions.width, 240);
    expect(dimensions.height, 360);
    expect(dimensions.depth, 90);
  });

  test('faceDisplaySize returns width x height for front', () {
    final dimensions = buildPrismDimensions(width: 240, height: 360, depth: 90);

    final size = faceDisplaySize('front', dimensions);

    expect(size.width, 240);
    expect(size.height, 360);
  });

  test('faceDisplaySize returns depth x height for left', () {
    final dimensions = buildPrismDimensions(width: 240, height: 360, depth: 90);

    final size = faceDisplaySize('left', dimensions);

    expect(size.width, 90);
    expect(size.height, 360);
  });

  test('faceDisplaySize returns width x depth for top', () {
    final dimensions = buildPrismDimensions(width: 240, height: 360, depth: 90);

    final size = faceDisplaySize('top', dimensions);

    expect(size.width, 240);
    expect(size.height, 90);
  });
}
