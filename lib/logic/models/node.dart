import 'package:oec2026/logic/map_scaler.dart';

enum NodeType {
  waste,
  local_sorting_facility, // ignore: constant_identifier_names
  regional_sorting_facility, // ignore: constant_identifier_names
  regional_recycling_facility, // ignore: constant_identifier_names
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
}
