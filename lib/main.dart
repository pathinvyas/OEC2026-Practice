import 'package:flutter/material.dart';
import 'package:oec2026/logic/background/background_manager.dart';
import 'package:oec2026/ui/screens/app_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Needed when main is async

  await BackgroundManager().init(); // Start the background worker

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OEC2026',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const AppScaffold(),
    );
  }
}
