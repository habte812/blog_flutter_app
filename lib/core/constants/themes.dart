import 'package:flutter/material.dart';

const Color background = Color(0xff101922);
// const Color context.primary = Color(0xff137fec);
Color card = Colors.white.withValues(alpha: 0.03);

// In constant.dart
extension ThemeContext on BuildContext {
  Color get primary => Theme.of(this).colorScheme.primary;
}

ThemeData getAppTheme(Color dynamicPrimary) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,

    // Pass the dynamic color here
    colorScheme: ColorScheme.dark(
      primary: dynamicPrimary,
      secondary: dynamicPrimary,
      surface: const Color(0xff16202a),
    ),

    // Use the dynamic color for specific components
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: dynamicPrimary,
      cursorColor: dynamicPrimary,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(dynamicPrimary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(
        0xff16202a,
      ), // Use a solid color for better performance
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: dynamicPrimary),
      ),
    ),

    // Apply to Dialogs, FloatingActionButtons, etc.
  );
}
