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
        initialZoom: 1.0,
      ),
      children: [
        GridLayer(),
        
        MarkerLayer(
          markers: [
            Marker(point: LatLng(1, 1), child: FlutterLogo()),
            Marker(point: LatLng(0, 0), child: FlutterLogo()),
          ],
        ),
      ],
    );
  }
}
