import 'dart:isolate';

import 'package:flutter/foundation.dart';

void backgroundEntry(SendPort servicePort) async {
  ReceivePort isolatePort = ReceivePort();

  servicePort.send(isolatePort.sendPort);

  if (kDebugMode) print("Background Isolate Ready");

  // Listen for messages forever
  await for (var message in isolatePort) {
    String data = message[0];
    SendPort replyPort = message[1];

    String processed = "Worker processed: ${data.toUpperCase()}";

    if (kDebugMode) print("Got message: $data");

    replyPort.send(processed);
  }
}
