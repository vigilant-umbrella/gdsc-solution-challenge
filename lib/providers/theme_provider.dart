import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/models/theme_props_model.dart';
import 'package:gdsc_solution_challenge/theme/blue_theme.dart';

class Themes with ChangeNotifier {
  final Map<ThemeTypes, ThemeProps> _themes = {
    ThemeTypes.blue: ThemeProps(
      backgroundGradient: blueBackgroundGradient,
      themeData: blueTheme,
    ),
  };

  ThemeData get currentTheme {
    return _themes[ThemeTypes.blue]!.themeData;
  }

  LinearGradient get currentThemeBackgroundGradient {
    return _themes[ThemeTypes.blue]!.backgroundGradient;
  }
}
