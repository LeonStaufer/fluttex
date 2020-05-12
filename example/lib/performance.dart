import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttex/math_view_static.dart';

class PerformanceScreen extends StatelessWidget {
  static final List<String> symbols = [
    "\\sum",
    "+",
    "\\frac",
    "-",
    "\\times",
    "\\text{ lol }",
    "\\int",
    "\\pi"
  ];

  static final List<Widget> mathViews =
      List.generate(50, (index) => generateMathView(index));

  static final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutTeX Performance Example"),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: mathViews,
      ),
    );
  }

  static Widget generateMathView(int index) {
    final color = Colors.primaries[random.nextInt(Colors.primaries.length)];
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      child: MathViewStatic(
        key: ValueKey(index),
        tex: randomTex(),
        displayMode: true,
        backgroundColor: color,
      ),
    );
  }

  static String randomTex() {
    String tex = random.nextInt(200).toString();
    for (int i = 0; i < 5; i++) {
      tex += randomSymbol();
      tex += random.nextInt(200).toString();
    }
    return tex;
  }

  static String randomSymbol() {
    return symbols[random.nextInt(symbols.length)];
  }
}
