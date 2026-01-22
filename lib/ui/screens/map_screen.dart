import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
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
        final markers =
            BackgroundManager().nodes?.values.map((Node node) {
              return Marker(
                point: LatLng(node.scaledLatitude(), node.scaledLongitude()),
                child: FlutterLogo(),
              );
            }).toList() ??
            [];

        return FlutterMap(
          options: MapOptions(
            crs: const CrsSimple(),
            initialCenter: const LatLng(0, 0),
            initialZoom: -6,
            maxZoom: MapScaler.getDynamicMaxZoom(),
            minZoom: -6,
          ),
          children: [
            GridLayer(),

            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 120,
                animationsOptions: const AnimationsOptions(zoom: Duration.zero),
                centerMarkerOnClick: true,
                zoomToBoundsOnClick: true,
                showPolygon: false,

                size: const Size(40, 40),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),

                markers: markers,

                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                      color: _getClusterColor(markers.length),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getClusterColor(int count) {
    if (count > 1000) return Colors.red;
    if (count > 100) return Colors.orange;
    return Colors.blue;
  }
}
