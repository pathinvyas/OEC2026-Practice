import 'dart:io';

import 'package:csv/csv.dart';
import 'package:oec2026/logic/models/node.dart';

enum CSVType { nodes, pathfinding }

Future<NodeManager> parseRecycleDataFromPath(String path) async {
  File file = File(path);
  List<List<String>> rows = const CsvToListConverter().convert(
    await file.readAsString(),
    shouldParseNumbers: false,
    eol: '\n',
  );

  NodeManager nodeManager = NodeManager();

  for (List<String> row in rows) {
    int nodeID = int.parse(row[0]);

    Node node = Node(
      nodeID: nodeID,
      latitude: int.parse(row[1]),
      longitude: int.parse(row[2]),
      nodeType: NodeType.values.byName(row[3]),
      plasticAmount: int.parse(row[4]),
      risk: double.parse(row[5]),
    );

    nodeManager.add(node);
  }

  return nodeManager;
}

Future<Map<int, Node>> parsePathfindingCSVFromPath(String path) async {
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
