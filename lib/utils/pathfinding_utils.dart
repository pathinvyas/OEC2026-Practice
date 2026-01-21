import 'dart:io';

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
}

Future<Map<int, Node>> parseRecycleDataFromPath(String path) async {
  File file = File(path);
  List<String> lines = await file.readAsLines();

  Map<int, Node> nodes = {};

  for (String line in lines) {
    List<String> split = line.split(",");

    int nodeID = int.parse(split[0]);

    Node node = Node(
      nodeID: nodeID,
      latitude: int.parse(split[1]),
      longitude: int.parse(split[2]),
      nodeType: NodeType.values.byName(split[3]),
      plasticAmount: int.parse(split[4]),
      risk: double.parse(split[5]),
    );
    
    nodes[nodeID] = node;
  }

  return nodes;
}
