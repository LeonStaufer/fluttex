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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutTeX Performance Example"),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: List.generate(50, (index) => generateMathView()),
      ),
    );
  }

  Widget generateMathView() {
    return Container(
      height: 50,
      child: MathViewStatic(
        tex: randomTex(),
        backgroundColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
      ),
    );
  }

  String randomTex() {
    String tex = Random().nextInt(200).toString();
    for (int i = 0; i < 5; i++) {
      tex += randomSymbol();
      tex += Random().nextInt(200).toString();
    }
    return tex;
  }

  String randomSymbol() {
    return symbols[Random().nextInt(symbols.length)];
  }
}
