import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:oec2026/services/background_isolate.dart';

class BackgroundService {
  late SendPort _backgroundSendPort;

  Future<void> init() async {
    ReceivePort backgroundReceivePort = ReceivePort();

    await Isolate.spawn(backgroundEntry, backgroundReceivePort.sendPort);

    // 3. Wait for the worker to send us its address
    _backgroundSendPort = await backgroundReceivePort.first;

    if (kDebugMode) print("Background Service Ready");
  }

  void sendMessage() async {
    // 1. Create a temporary mailbox just for THIS reply
    ReceivePort responsePort = ReceivePort();

    // 2. Send the message AND the reply address to the worker
    // We send a list: ["Hello", replyPort]
    _backgroundSendPort.send(["Hello from UI", responsePort.sendPort]);

    // 3. Wait for the answer
    final response = await responsePort.first;

    if (kDebugMode) print("Got response: $response");
  }
}
