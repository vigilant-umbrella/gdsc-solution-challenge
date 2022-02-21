import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const blueBackgroundGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 178, 96, 255),
    Color.fromARGB(255, 80, 167, 255),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// make all texts white
var textTheme = TextTheme(
  bodyText1: GoogleFonts.redHatDisplayTextTheme().bodyText1?.copyWith(
        color: Colors.white,
      ),
  bodyText2: GoogleFonts.redHatDisplayTextTheme().bodyText2?.copyWith(
        color: Colors.white,
      ),
  button: GoogleFonts.redHatDisplayTextTheme().button?.copyWith(
        color: Colors.white,
      ),
  caption: GoogleFonts.redHatDisplayTextTheme().caption?.copyWith(
        color: Colors.white,
      ),
  headline1: GoogleFonts.redHatDisplayTextTheme().headline1?.copyWith(
        color: Colors.white,
      ),
  headline2: GoogleFonts.redHatDisplayTextTheme().headline2?.copyWith(
        color: Colors.white,
      ),
  headline3: GoogleFonts.redHatDisplayTextTheme().headline3?.copyWith(
        color: Colors.white,
      ),
  headline4: GoogleFonts.redHatDisplayTextTheme().headline4?.copyWith(
        color: Colors.white,
      ),
  headline5: GoogleFonts.redHatDisplayTextTheme().headline5?.copyWith(
        color: Colors.white,
      ),
  headline6: GoogleFonts.redHatDisplayTextTheme().headline6?.copyWith(
        color: Colors.white,
      ),
  subtitle1: GoogleFonts.redHatDisplayTextTheme().subtitle1?.copyWith(
        color: Colors.white,
      ),
  subtitle2: GoogleFonts.redHatDisplayTextTheme().subtitle2?.copyWith(
        color: Colors.white,
      ),
  overline: GoogleFonts.redHatDisplayTextTheme().overline?.copyWith(
        color: Colors.white,
      ),
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
