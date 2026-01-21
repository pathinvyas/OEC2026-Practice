import 'dart:isolate';

class BackgroundCommand {
  final SendPort replyPort;

  BackgroundCommand({required this.replyPort});
}

class LoadCSVCommand extends BackgroundCommand {
  final String path;

  LoadCSVCommand({required super.replyPort, required this.path});
}
