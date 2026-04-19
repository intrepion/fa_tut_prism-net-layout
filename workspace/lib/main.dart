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
