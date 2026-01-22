import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:oec2026/logic/background/background_manager.dart';
import 'package:oec2026/logic/map_scaler.dart';
import 'package:oec2026/logic/models/node.dart';
import 'package:oec2026/ui/common/grid_layer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: BackgroundManager(),
      builder: (context, child) {
        return FlutterMap(
          options: MapOptions(
            crs: const CrsSimple(),
            initialCenter: const LatLng(0, 0),
            initialZoom: 0,
            maxZoom: MapScaler.getDynamicMaxZoom(),
            minZoom: -6,
          ),
          children: [
            GridLayer(),

            MarkerLayer(
              markers:
                  BackgroundManager().nodes?.values.map((Node node) {
                    return Marker(
                      point: LatLng(
                        node.scaledLatitude(),
                        node.scaledLongitude(),
                      ),
                      child: FlutterLogo(),
                    );
                  }).toList() ??
                  [],
            ),
          ],
        );
      },
    );
  }
}