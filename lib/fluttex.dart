import 'dart:async';

import 'package:flutter/services.dart';

class Fluttex {
  static const MethodChannel _channel =
      const MethodChannel('fluttex');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
