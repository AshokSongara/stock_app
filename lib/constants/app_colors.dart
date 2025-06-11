import 'package:flutter/cupertino.dart';

/// This file contains all the color constants used in the application.
/// Centralizing colors makes it easier to maintain a consistent theme.

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2196F3); // Blue
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFFBBDEFB);
  
  // Accent Colors
  static const Color accent = Color(0xFF03A9F4); // Light Blue
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  
  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFFE0E0E0);
  static const Color cardBackground = Color(0xFFF8F9FA);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Stock Market Colors
  static const Color stockPositive = Color(0xFF4CAF50); // Green
  static const Color stockNegative = Color(0xFFF44336); // Red
  static const Color positive = Color(0xFF4CAF50); // Green
  static const Color negative = Color(0xFFF44336); // Red
  
  // Form Field Colors
  static const Color inputBackground = Color(0xFFF5F5F5);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocusBorder = primary;
  static const Color inputErrorBorder = error;
  
  // Button Colors
  static const Color buttonBackground = primary;
  static const Color buttonText = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderColor = Color(0xFF757570);

  // Cupertino Colors Mapping
  static const CupertinoDynamicColor cupertinoPrimary = CupertinoColors.systemBlue;
  static const CupertinoDynamicColor cupertinoBackground = CupertinoColors.systemBackground;
  static const CupertinoDynamicColor cupertinoError = CupertinoColors.systemRed;
  static const CupertinoDynamicColor cupertinoSuccess = CupertinoColors.systemGreen;
  static const CupertinoDynamicColor cupertinoInputBackground = CupertinoColors.systemGrey6;
}