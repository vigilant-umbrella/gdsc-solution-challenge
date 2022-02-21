import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/theme/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

const blueBackgroundGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 178, 96, 255),
    Color.fromARGB(255, 80, 167, 255),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

var blueTheme = ThemeData(
  fontFamily: GoogleFonts.redHatDisplay().fontFamily,
  backgroundColor: Colors.transparent,
  primarySwatch: Colors.purple,
  canvasColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
  ),
  textTheme: textTheme,
  colorScheme: const ColorScheme(
    primary: Colors.purple,
    onPrimary: Colors.white,
    secondary: Colors.pink,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
);
