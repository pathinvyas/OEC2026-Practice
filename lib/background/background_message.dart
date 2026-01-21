import 'dart:isolate';

class BackgroundMessage {
  final SendPort replyPort;

  BackgroundMessage({required this.replyPort});
}

class LoadCSVMessage extends BackgroundMessage {
  final String path;

  LoadCSVMessage({
    required super.replyPort, 
    required this.path,
  });
}
