import 'package:oec2026/logic/models/node.dart';

class BackgroundResponse {
  final String? error;

  BackgroundResponse({this.error});
}

class LoadCSVResponse extends BackgroundResponse {
  final NodeManager nodeManager;
  final double scaleFactor;

  LoadCSVResponse({super.error, required this.nodeManager, required this.scaleFactor});
}
