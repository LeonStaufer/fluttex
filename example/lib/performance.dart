import 'package:flutter/material.dart';

class PerformanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutTeX Performance Example"),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: mathViews(),
      ),
    );
  }

  List<Widget> mathViews() {
    List<Widget> widgets = [];

    return widgets;
  }
}
