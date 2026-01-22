import 'package:oec2026/logic/models/node.dart';

class BackgroundResponse {
  final String? error;

  BackgroundResponse({this.error});
}

class LoadCSVResponse extends BackgroundResponse {
  final Map<int, Node> nodes;
  final double scaleFactor;

  LoadCSVResponse({super.error, required this.nodes, required this.scaleFactor});
}
