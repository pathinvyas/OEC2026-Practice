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

    double gridStep;

    if (visibleWidth < 2) {
      gridStep = 0.1; // Real: 100k increments
    } else if (visibleWidth < 10) {
      gridStep = 1.0; // Real: 1 Million increments (Standard)
    } else if (visibleWidth < 50) {
      gridStep = 5.0; // Real: 5 Million increments
    } else {
      gridStep = 10.0; // Real: 10 Million increments
    }

    final startX = (minX / gridStep).floor() * gridStep;

    for (double x = startX; x <= maxX; x += gridStep) {
      // LatLng(y, x) -> standard CrsSimple mapping
      final top = camera.latLngToScreenOffset(LatLng(maxY, x));
      final bottom = camera.latLngToScreenOffset(LatLng(minY, x));
      canvas.drawLine(top, bottom, paint);
    }

    // 5. Draw Horizontal Lines (Y Axis)
    final startY = (minY / gridStep).floor() * gridStep;

    for (double y = startY; y <= maxY; y += gridStep) {
      final left = camera.latLngToScreenOffset(LatLng(y, minX));
      final right = camera.latLngToScreenOffset(LatLng(y, maxX));
      canvas.drawLine(left, right, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
