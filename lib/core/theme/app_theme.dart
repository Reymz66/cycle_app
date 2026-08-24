import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color periodColor = Color(0xFFE0567A);
  static const Color predictedPeriodColor = Color(0xFFF2A6BC);
  static const Color fertileWindowColor = Color(0xFF9C89D6);
  static const Color ovulationColor = Color(0xFF5E3FBE);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFB05C7A),
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
    );
  }
}
