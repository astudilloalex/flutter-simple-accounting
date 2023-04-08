import 'package:flutter/material.dart';

class AppThemeData {
  const AppThemeData._();

  static ThemeData get dark {
    return ThemeData.dark().copyWith();
  }

  static ThemeData get light {
    return ThemeData.light().copyWith(
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.teal),
        ),
      ),
    );
  }
}
