import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:oec2026/logic/background/background_manager.dart';
import 'package:oec2026/ui/common/output_console.dart';

class CSVScreen extends StatefulWidget {
  const CSVScreen({super.key});

  @override
  State<CSVScreen> createState() => _CSVScreenState();
}

class _CSVScreenState extends State<CSVScreen> {
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

      await BackgroundManager().loadCSV(path);

      setState(() {
        _csvInfo = "Loaded: ${BackgroundManager().nodeManager.length} nodes";
      });
    } catch (e) {
      setState(() {
        _csvInfo = "Failed to get CSV data: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          OutputConsole(text: _csvInfo),

          SizedBox(height: 20),

          ElevatedButton(onPressed: _loadCSV, child: Text("Add CSV")),
        ],
      ),
    );
  }
}
