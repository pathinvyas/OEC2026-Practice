import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:oec2026/services/background_isolate.dart';

class BackgroundService {
  late SendPort _backgroundSendPort;

  Future<void> init() async {
    ReceivePort backgroundReceivePort = ReceivePort();

    await Isolate.spawn(backgroundEntry, backgroundReceivePort.sendPort);

    _backgroundSendPort = await backgroundReceivePort.first;

    if (kDebugMode) print("Background Service Ready");
  }

  void sendMessage() async {
    ReceivePort responsePort = ReceivePort();

    _backgroundSendPort.send(["Hello from UI", responsePort.sendPort]);

    final response = await responsePort.first;

    if (kDebugMode) print("Got response: $response");
  }
}
