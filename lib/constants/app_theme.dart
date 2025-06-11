import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

/// This file contains theme configurations for both Material and Cupertino designs.
/// It uses the color constants defined in AppColors.

class AppTheme {
  // Material Theme
  static ThemeData materialTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        error: AppColors.error,
        surface: AppColors.background,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
          borderSide: BorderSide(color: AppColors.inputFocusBorder, width: AppDimensions.borderWidthSmall.r),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
          borderSide: BorderSide(color: AppColors.inputErrorBorder, width: AppDimensions.borderWidthSmall.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
          borderSide: BorderSide(color: AppColors.inputErrorBorder, width: AppDimensions.borderWidthSmall.r),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.inputFieldPaddingHorizontal.w,
          vertical: AppDimensions.inputFieldPaddingVertical.h,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.buttonBackground,
          foregroundColor: AppColors.buttonText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal.w,
            vertical: AppDimensions.buttonPaddingVertical.h,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.primary,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
        ),
      ),
    );
  }

  // Cupertino Theme
  static CupertinoThemeData cupertinoTheme() {
    return const CupertinoThemeData(
      primaryColor: AppColors.cupertinoPrimary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.cupertinoBackground,
      barBackgroundColor: AppColors.cupertinoBackground,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.cupertinoPrimary,
        textStyle: TextStyle(color: AppColors.textPrimary),
      ),
    );
  }
}