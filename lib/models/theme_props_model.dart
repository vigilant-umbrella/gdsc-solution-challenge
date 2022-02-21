import 'package:flutter/material.dart';

class ThemeProps {
  final ThemeData themeData;
  final LinearGradient backgroundGradient;

  ThemeProps({
    required this.themeData,
    required this.backgroundGradient,
  });
}

enum ThemeTypes {
  blue,
}
