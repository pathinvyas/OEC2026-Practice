import 'dart:io';

import 'package:oec2026/logic/models/node.dart';

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
