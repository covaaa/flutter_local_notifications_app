import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpApp({required Widget child, bool scaffold = true}) async {
    return pumpWidget(
      MaterialApp(home: scaffold ? Scaffold(body: child) : child),
    );
  }
}
