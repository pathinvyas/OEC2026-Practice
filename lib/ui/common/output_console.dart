import 'package:flutter/material.dart';

class OutputConsole extends StatelessWidget {
  final String text;
  final double height;
  final double width;

  const OutputConsole({
    super.key,
    required this.text,
    this.height = 200.0,
    this.width = 500.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 500,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SelectableText(text),
        ),
      ),
    );
  }
}
