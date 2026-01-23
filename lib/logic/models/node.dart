// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:oec2026/logic/map_scaler.dart';

enum NodeType {
  waste(icon: Icons.delete_outline, color: Colors.black, tooltip: "1. Waste"),
  local_sorting_facility(
    icon: Icons.warehouse_outlined,
    color: Colors.blueGrey,
    tooltip: "2. Local Sorting Facility",
  ),
  regional_sorting_facility(
    icon: Icons.factory_outlined,
    color: Colors.blueAccent,
    tooltip: "3. Regional Sorting Facility",
  ),
  regional_recycling_facility(
    icon: Icons.recycling,
    color: Colors.green,
    tooltip: "4. Recycling Facility",
  );

  final IconData icon;
  final Color color;
  final String tooltip;

  const NodeType({
    required this.icon,
    required this.color,
    required this.tooltip,
  });
}

class Node {
  final int nodeID;
  final int latitude;
  final int longitude;
  final NodeType nodeType;
  final int plasticAmount;
  final double risk;

  Node({
    required this.nodeID,
    required this.latitude,
    required this.longitude,
    required this.nodeType,
    required this.plasticAmount,
    required this.risk,
  });

  @override
  String toString() {
    return "Node(nodeID: $nodeID, latitude: $latitude, longitude: $longitude, nodeType: $nodeType, plasticAmount: $plasticAmount, risk: $risk)";
  }

  double scaledLatitude() {
    return MapScaler.scaleDownInt(latitude);
  }

  double scaledLongitude() {
    return MapScaler.scaleDownInt(longitude);
  }

  Widget iconWidget() {
    return Tooltip(
      message: nodeType.tooltip,

      waitDuration: const Duration(milliseconds: 200),

      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: nodeType.color,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(
          child: Icon(nodeType.icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

class NodeManager {
  final List<Node> wasteNodes = [];
  final List<Node> localSortNodes = [];
  final List<Node> regionalSortNodes = [];
  final List<Node> recycleNodes = [];

  final Map<int, Node> _nodeIndex = {};
  int get length => _nodeIndex.length;

  void add(Node node) {
    if (_nodeIndex.containsKey(node.nodeID)) {
      throw Exception("Node with ID ${node.nodeID} already exists");
    }

    _nodeIndex[node.nodeID] = node;

    switch (node.nodeType) {
      case NodeType.waste:
        wasteNodes.add(node);
        break;
      case NodeType.local_sorting_facility:
        localSortNodes.add(node);
        break;
      case NodeType.regional_sorting_facility:
        regionalSortNodes.add(node);
        break;
      case NodeType.regional_recycling_facility:
        recycleNodes.add(node);
        break;
    }
  }

  Node? getNodeById(int id) => _nodeIndex[id];

  List<Node> toList() {
    return [
      ...wasteNodes,
      ...localSortNodes,
      ...regionalSortNodes,
      ...recycleNodes,
    ];
  }
}
