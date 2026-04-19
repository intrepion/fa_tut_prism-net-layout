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
    final dimensions = buildPrismDimensions(width: 240, height: 360, depth: 90);
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
