import 'dart:isolate';

import 'package:flutter/foundation.dart';

void backgroundEntry(SendPort backgroundSendPort) async {
  ReceivePort backgroundReceivePort = ReceivePort();

  backgroundSendPort.send(backgroundReceivePort.sendPort);

  if (kDebugMode) print("Background Isolate Ready");

  // Listen for messages forever
  await for (var message in backgroundReceivePort) {
    String data = message[0];
    SendPort replyPort = message[1];

    String processed = "Worker processed: ${data.toUpperCase()}";

    if (kDebugMode) print("Got message: $data");

    replyPort.send(processed);
  }
}
