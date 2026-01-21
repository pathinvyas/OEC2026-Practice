import 'package:oec2026/utils/pathfinding_utils.dart';

class BackgroundResponse {
  final String? error;

  BackgroundResponse({this.error});
}

class LoadCSVResponse extends BackgroundResponse {
  final Map<int, Node> nodes;

  LoadCSVResponse({super.error, required this.nodes});
}
