import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:oec2026/logic/background/background_isolate.dart';
import 'package:oec2026/logic/map_scaler.dart';
import 'package:oec2026/logic/models/background_command.dart';
import 'package:oec2026/logic/models/background_response.dart';
import 'package:oec2026/logic/models/node.dart';
import 'package:oec2026/logic/models/recycle_route.dart';

class BackgroundManager with ChangeNotifier {
  NodeManager nodeManager = NodeManager();
  RecycleRouteManager recycleRouteManager = RecycleRouteManager();

  static final BackgroundManager _instance = BackgroundManager._internal();
  factory BackgroundManager() => _instance;
  BackgroundManager._internal();

  late SendPort _isolatePort;

  Future<void> init() async {
    ReceivePort managerPort = ReceivePort();

    await Isolate.spawn(backgroundEntry, managerPort.sendPort);

    _isolatePort = await managerPort.first;

    if (kDebugMode) print("Background Service Ready");
  }

  Future<void> loadCSV(String path) async {
    ReceivePort responsePort = ReceivePort();

    if (kDebugMode) print("Sending message");

    _isolatePort.send(
      LoadCSVCommand(replyPort: responsePort.sendPort, path: path),
    );

    final LoadCSVResponse response = await responsePort.first;

    if (response.error != null) throw Exception(response.error);

    nodeManager = response.nodeManager;
    MapScaler.scaleFactor = response.scaleFactor;
    notifyListeners();
  }
}
