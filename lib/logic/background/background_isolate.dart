import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:oec2026/logic/models/background_command.dart';
import 'package:oec2026/logic/models/background_response.dart';
import 'package:oec2026/logic/models/node.dart';
import 'package:oec2026/logic/csv_logic.dart';
import 'package:oec2026/logic/models/recycle_route.dart';

void backgroundEntry(SendPort managerPort) async {
  Map<int, Node>? nodes;
  Map<int, RecycleRoute>? recycleRoutes;

  ReceivePort isolatePort = ReceivePort();

  managerPort.send(isolatePort.sendPort);

  if (kDebugMode) print("Background Isolate Ready");

  // Listen for messages forever
  await for (var message in isolatePort) {
    switch (message) {
      case LoadCSVCommand():
        if (kDebugMode) print("Got load csv command for: ${message.path}");

        try {
          nodes = await parseRecycleDataFromPath(message.path);

          message.replyPort.send(LoadCSVResponse(nodes: nodes));
        } catch (e) {
          if (kDebugMode) {
            print(
              "Failed to parse: ${message.path}, with error: ${e.toString()}",
            );
          }

          message.replyPort.send(
            LoadCSVResponse(error: e.toString(), nodes: {}),
          );
        }
    }
  }
}
