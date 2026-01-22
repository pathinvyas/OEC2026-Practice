import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class GridLayer extends StatelessWidget {
  const GridLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);

    return CustomPaint(painter: _GridPainter(camera), size: Size.infinite);
  }
}

class _GridPainter extends CustomPainter {
  final MapCamera camera;
  _GridPainter(this.camera);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final bounds = camera.visibleBounds;

    final minX = bounds.west;
    final maxX = bounds.east;
    final minY = bounds.south;
    final maxY = bounds.north;

    double visibleWidth = (maxX - minX).abs();

    double stepSize = _calculateStepSize(visibleWidth);

    final startX = (minX / stepSize).floor() * stepSize;

    for (double x = startX; x <= maxX; x += stepSize) {
      final top = camera.latLngToScreenOffset(LatLng(maxY, x));
      final bottom = camera.latLngToScreenOffset(LatLng(minY, x));
      canvas.drawLine(top, bottom, paint);
    }

    final startY = (minY / stepSize).floor() * stepSize;

    for (double y = startY; y <= maxY; y += stepSize) {
      final left = camera.latLngToScreenOffset(LatLng(y, minX));
      final right = camera.latLngToScreenOffset(LatLng(y, maxX));
      canvas.drawLine(left, right, paint);
    }
  }

  double _calculateStepSize(double visibleRange) {
    if (visibleRange <= 0.0000001) return 1.0;

    // Change how many grid lines on screen here
    double targetStep = visibleRange / 25;

    double magnitude = math.pow(10, (math.log(targetStep) / math.ln10).floor()).toDouble();

    double residual = targetStep / magnitude;
    
    if (residual > 5) {
      return 10 * magnitude;
    } else if (residual > 2) {
      return 5 * magnitude;
    } else {
      return magnitude;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
