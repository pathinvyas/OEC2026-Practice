import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:oec2026/logic/background/background_manager.dart';
import 'package:oec2026/logic/map_scaler.dart';
import 'package:oec2026/ui/common/grid_layer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isMapGenerated = false;
  bool _isGenerating = false;
  int _nodesLoaded = 0;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    BackgroundManager().addListener(onDataChanged);
  }

  void onDataChanged() {
    if (mounted) {
      setState(() {
        _isMapGenerated = false;
      });
    }
  }

  Future<void> _generateMarkers() async {
    final nodes = BackgroundManager().nodes?.values.toList() ?? [];
    if (nodes.isEmpty) return;

    setState(() {
      _isGenerating = true;
      _nodesLoaded = 0;
    });

    final List<Marker> tempMarkers = [];
    const int chunkSize = 2000; // Process 2000 at a time

    for (var i = 0; i < nodes.length; i += chunkSize) {
      int end = (i + chunkSize < nodes.length) ? i + chunkSize : nodes.length;

      var chunk = nodes.sublist(i, end).map((node) {
        return Marker(
          point: LatLng(node.scaledLatitude(), node.scaledLongitude()),
          //width: 10,
          //height: 10,
          child: const FlutterLogo(),
        );
      });

      tempMarkers.addAll(chunk);

      if (mounted) {
        setState(() {
          _nodesLoaded = tempMarkers.length;
        });
      }

      await Future.delayed(Duration.zero);
    }

    if (mounted) {
      setState(() {
        _markers = tempMarkers;
        _isMapGenerated = true;
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int nodeCount = BackgroundManager().nodes?.length ?? 0;

    if (nodeCount == 0) {
      return const Center(child: Text("No data loaded. Import a CSV."));
    }

    if (_isGenerating) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text("Building Map... $_nodesLoaded / $nodeCount"),
            Text(
              "$nodeCount Nodes",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    if (!_isMapGenerated) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 64, color: Colors.blue[300]),
            const SizedBox(height: 20),
            Text(
              "$nodeCount Nodes Loaded",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _generateMarkers,
              icon: const Icon(Icons.build_circle_outlined),
              label: const Text("Generate Map"),
            ),
          ],
        ),
      );
    }

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

            markers: _markers,

            builder: (context, markers) {
              return Container(
                decoration: BoxDecoration(
                  color: _getClusterColor(markers.length),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    markers.length <= 99 ? markers.length.toString() : "99+" ,
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
  }

  Color _getClusterColor(int count) {
    if (count > 1000) return Colors.red;
    if (count > 100) return Colors.orange;
    return Colors.blue;
  }
}
