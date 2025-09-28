import 'package:flutter/material.dart';

class AppTheme {
  static const Color milestoneBlue = Color(0xFF1e40af);
  static const Color milestoneCyan = Color(0xFF0891b2);
  static const Color milestoneNavy = Color(0xFF1e293b);
  static const Color milestoneRed = Color(0xFFef4444);
  static const Color milestoneGold = Color(0xFFf59e0b);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: milestoneBlue,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: milestoneNavy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: milestoneBlue,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: milestoneNavy,
      appBarTheme: const AppBarTheme(
        backgroundColor: milestoneNavy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
  
  static const LinearGradient milestoneGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      milestoneNavy,
      milestoneBlue,
      milestoneCyan,
    ],
  );
}
