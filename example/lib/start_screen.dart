import 'package:flutter/material.dart';
import 'package:fluttex/math_view_static.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  final _textController = TextEditingController();
  MathViewController _mathViewController;

  @override
  void initState() {
    super.initState();

    //render the TeX once the input changes
    _textController.addListener(() {
      _mathViewController?.render(_textController.text);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('fluttex Example'),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 150,
            child: MathViewStatic(
              displayMode: true,
              tex: "\\text{Static MathView Example} \\\\"
                  "\\int_{-\\infty}^\\infty \\hat f(\\xi)\\,e^{2 \\pi i \\xi x} \\,d\\xi \\\\"
                  "\\ce{\$K = \\frac{[\ce{Hg^2+}][\\ce{Hg}]}{[\\ce{Hg2^2+}]}\$}",
            ),
          ),
          Divider(),
          Text(
            "Dynamic MathView Example",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Container(
            height: 200,
            child: MathViewStatic(
              key: UniqueKey(),
              displayMode: true,
              color: Colors.white,
              backgroundColor: Colors.black87,
              onMathViewCreated: (controller) {
                _mathViewController = controller;
              },
            ),
          ),
          Divider(),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
                hintText:
                    "Starting typing to have the TeX be rendered above..."),
          ),
          RaisedButton(
              child: Text("Performance Example"),
              onPressed: () => Navigator.of(context).pushNamed("/performance"))
        ],
      ),
    );
  }
}
