import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpRiverpodWidget({
    required Widget child,
    List<Override> overrides = const [],
  }) {
    return pumpWidget(ProviderScope(overrides: overrides, child: child));
  }

  Future<void> pumpApp({
    required Widget child,
    bool scaffold = true,
    List<Override> overrides = const [],
  }) async {
    return pumpRiverpodWidget(
      overrides: overrides,
      child: MaterialApp(home: scaffold ? Scaffold(body: child) : child),
    );
  }
}
