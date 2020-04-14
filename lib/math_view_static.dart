import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// define a type for MathView callback.
typedef MathViewCreatedCallback = void Function(MathViewController controller);

/// A static MathView that renders TeX using KaTeX.
class MathViewStatic extends StatelessWidget {
  MathViewStatic(
      {Key key,
      this.onMathViewCreated,
      this.color = Colors.black87,
      this.backgroundColor = Colors.white,
      this.errorColor = const Color(0xFFCC0000),
      this.fontSize = 16,
      this.displayMode = false,
      this.leqno = false,
      this.fleqn = false,
      this.throwOnError = false,
      this.tex})
      : super(key: key);

  /// A function to be called when the MathView has loaded.
  final MathViewCreatedCallback onMathViewCreated;

  /// The color for the TeX string.
  final Color color;

  /// The background color of view.
  final Color backgroundColor;

  /// The text color when an error occurs during rendering.
  final Color errorColor;

  /// The font size of the TeX.
  final int fontSize;

  /// Whether the TeX should be rendered in display mode,
  /// so that it is centered and symbols are larger.
  final bool displayMode;

  /// If tags should be rendered on the left side instead of right.
  final bool leqno;

  /// If display math should be rendered flush left.
  final bool fleqn;

  /// If an exception should be thrown if an error occurs or if
  /// the error should be displayed in [errorColor].
  final bool throwOnError;

  /// The TeX that should be rendered.
  final String tex;

  /// builds the MathView dependent on the platform
  /// using the given [context].
  @override
  Widget build(BuildContext context) {
    // Map of parameters that can be passed to the native views
    Map _parameters = {
      "color": _toColorString(color),
      "backgroundColor": _toColorString(backgroundColor),
      "errorColor": _toColorString(errorColor),
      "fontSize": fontSize,
      "displayMode": displayMode,
      "leqno": leqno,
      "fleqn": fleqn,
      "throwOnError": throwOnError,
      "tex": tex,
    };

    Widget child;

    // create different child widgets dependent on platform
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        {
          child = AndroidView(
            viewType: 'mathview',
            onPlatformViewCreated: _onPlatformViewCreated,
            creationParams: _parameters,
            creationParamsCodec: StandardMessageCodec(),
          );
          break;
        }

      // TODO add other platforms
      default:
        {
          child = Text(
            'MathView for ${Theme.of(context).platform} is not yet supported by the fluttex plugin',
            style: TextStyle(
              color: color,
            ),
            textAlign: displayMode ? TextAlign.center : TextAlign.start,
          );
        }
    }

    return Container(
      color: backgroundColor,
      child: child,
    );
  }

  /// A callback for when the native platform view is created.
  /// Uses the [id] to create a MathViewController
  void _onPlatformViewCreated(int id) {
    if (onMathViewCreated == null) {
      return;
    }

    onMathViewCreated(MathViewController(id));
  }

  /// Helper method that converts a [color] to a HEX string
  static String _toColorString(Color color) {
    return "#${color.value.toRadixString(16).padLeft(8, '0')}";
  }
}

/// Controller for communicating with the MathView
class MathViewController {
  MathViewController(int id) {
    _channel = MethodChannel("MathView:$id");
  }

  MethodChannel _channel;

  /// Render the passed [tex] string asynchronously.
  Future<void> render(String tex) async {
    return _channel.invokeMethod("render", tex);
  }
}
