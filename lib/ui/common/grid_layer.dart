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
  final double gridSize = 1.0;

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

    final startX = (minX / gridSize).floor() * gridSize;

    for (double x = startX; x <= maxX; x += gridSize) {
      final top = camera.latLngToScreenOffset(LatLng(maxY, x));
      final bottom = camera.latLngToScreenOffset(LatLng(minY, x));

      canvas.drawLine(top, bottom, paint);
    }

    final startY = (minY / gridSize).floor() * gridSize;

    for (double y = startY; y <= maxY; y += gridSize) {
      final left = camera.latLngToScreenOffset(LatLng(y, minX));
      final right = camera.latLngToScreenOffset(LatLng(y, maxX));

      canvas.drawLine(left, right, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
