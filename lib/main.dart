import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:oec2026/background/background_manager.dart';
import 'package:oec2026/background/background_message.dart';

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
      home: const MyHomePage(title: 'OEC2026'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _csvInfo = "";

  void _loadCSV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["csv"],
    );

    try {
      if (result == null) throw Exception("User canceled file picker");

      final path = result.files.single.path;

      if (path == null) throw Exception("Path is null");

      BackgroundManager().loadCSV(path);
    } catch (e) {
      debugPrint("Failed to get CSV data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SelectableText(_csvInfo),
                ),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: _loadCSV, child: Text("Add CSV")),
          ],
        ),
      ),
    );
  }
}
