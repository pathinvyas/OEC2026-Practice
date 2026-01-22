import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:oec2026/ui/common/grid_layer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        crs: const CrsSimple(),
        initialCenter: const LatLng(0, 0),
        initialZoom: 20,
        maxZoom: 20,
        minZoom: -4,
        
      ),
      children: [
        GridLayer(),

        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(
                MapScaler.scaleDown(15663244),
                MapScaler.scaleDown(36240801),
              ),
              child: FlutterLogo(),
            ),
            Marker(
              point: LatLng(
                MapScaler.scaleDown(1),
                MapScaler.scaleDown(1),
              ),
              child: FlutterLogo(),
            ),
            Marker(point: LatLng(0, 0), child: FlutterLogo()),
          ],
        ),
      ],
    );
  }
}

class MapScaler {
  static const double scaleFactor = 1000000.0;

  static double scaleDown(double realValue) {
    return realValue / scaleFactor;
  }

  static double scaleUp(double mapValue) {
    return mapValue * scaleFactor;
  }
}
