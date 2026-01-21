import 'package:flutter/material.dart';

import 'package:oec2026/ui/screens/csv_screen.dart';
import 'package:oec2026/ui/screens/map_screen.dart';
import 'package:oec2026/ui/screens/pathfinding_screen.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CSVScreen(),
    const PathfindingScreen(),
    const MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("OEC2026"),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.insert_drive_file),
            label: "Import/Export",
          ),
          NavigationDestination(icon: Icon(Icons.hub), label: "Pathfinding"),
          NavigationDestination(icon: Icon(Icons.map), label: "Map"),
        ],
      ),
    );
  }
}
