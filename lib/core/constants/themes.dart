import 'package:flutter/material.dart';

const Color background = Color(0xff101922);
const Color primary = Color(0xff137fec);
Color card = Colors.white.withValues(alpha: 0.03);

ThemeData themeData = ThemeData(
  primaryColor: background,
  scaffoldBackgroundColor: background,
  brightness: .dark,
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: primary,
    cursorColor: primary,
  ),
  checkboxTheme: CheckboxThemeData(fillColor: WidgetStateProperty.all(primary)),
  dialogTheme: DialogThemeData(
    backgroundColor: card,
    shape: RoundedRectangleBorder(borderRadius: .circular(10)),
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: card,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: primary),
    ),
    labelStyle: const TextStyle(color: Colors.white70),
  ),
);
