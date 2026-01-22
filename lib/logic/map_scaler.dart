import 'dart:math' as math;

import 'package:oec2026/logic/models/node.dart';

class MapScaler {
  static double scaleFactor = 1;

  static double scaleDown(double realValue) {
    return realValue / scaleFactor;
  }

  static double scaleDownInt(int realValue) {
    return realValue / scaleFactor;
  }

  static double calibrate(List<Node> nodes) {
    if (nodes.isEmpty) return 1;

    int maxCoord = 0;

    for (var node in nodes) {
      if (node.longitude.abs() > maxCoord) maxCoord = node.longitude.abs();
      if (node.latitude.abs() > maxCoord) maxCoord = node.latitude.abs();
    }

    if (maxCoord > 80.0) {
      return maxCoord / 80.0;
    } else {
      return 1.0;
    }
  }

  static double getDynamicMaxZoom() {
    if (scaleFactor <= 1) return 20.0;

    double requiredZoom = math.log(scaleFactor) / math.ln2;

    return requiredZoom - 1;
  }
}
