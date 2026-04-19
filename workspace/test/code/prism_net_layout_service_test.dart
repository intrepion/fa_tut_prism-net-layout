import 'package:prism_net_layout/code/prism_net_layout_service.dart';
import 'package:prism_net_layout/contracts/face_crop_plan.dart';
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

  test(
    'buildPrismNetLayout preserves canonical order and hides missing faces',
    () {
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

      expect(layout.map((item) => item.faceName).toList(), [
        'front',
        'back',
        'left',
        'right',
        'top',
        'bottom',
      ]);

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
    },
  );
}
