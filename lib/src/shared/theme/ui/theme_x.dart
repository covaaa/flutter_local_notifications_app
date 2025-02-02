import 'package:flutter/material.dart';

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get titleMediumBold {
    return titleMedium?.copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle? get bodyMediumBold {
    return bodyMedium?.copyWith(fontWeight: FontWeight.bold);
  }
}
