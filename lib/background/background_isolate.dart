import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:oec2026/background/background_message.dart';

void backgroundEntry(SendPort managerPort) async {
  ReceivePort isolatePort = ReceivePort();

  managerPort.send(isolatePort.sendPort);

  if (kDebugMode) print("Background Isolate Ready");

  // Listen for messages forever
  await for (var message in isolatePort) {
    switch (message) {
      case LoadCSVMessage():
        if (kDebugMode) print("Got message: ${message.path}");
        message.replyPort.send("Succsess");
    }
  }
}
