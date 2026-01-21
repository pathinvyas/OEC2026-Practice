import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:oec2026/background/background_isolate.dart';
import 'package:oec2026/background/background_message.dart';

class BackgroundManager {
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

  void loadCSV(String path) async {
    ReceivePort responsePort = ReceivePort();

    if (kDebugMode) print("Sending message");

    _isolatePort.send(
      LoadCSVMessage(replyPort: responsePort.sendPort, path: path),
    );

    final response = await responsePort.first;

    if (kDebugMode) print("Got response: $response");
  }
}
