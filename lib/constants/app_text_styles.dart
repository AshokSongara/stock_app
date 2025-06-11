import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

/// This file contains all the text styles used in the application.
/// Centralizing text styles makes it easier to maintain consistent typography.

class AppTextStyles {
  // Stock List Item Styles
  static TextStyle get symbol => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get name => TextStyle(
    fontSize: 12.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get ltp => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get label => TextStyle(
    fontSize: 12.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get change => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get changePercent => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  // Stock Index Header Styles
  static TextStyle get indexName => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get indexValue => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get indexChange => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  // Form Field Styles
  static TextStyle get inputLabel => TextStyle(
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get inputText => TextStyle(
    fontSize: 16.sp,
    color: AppColors.textPrimary,
  );

  static TextStyle get inputHint => TextStyle(
    fontSize: 16.sp,
    color: AppColors.textHint,
  );

  static TextStyle get inputError => TextStyle(
    fontSize: 12.sp,
    color: AppColors.error,
  );

  // Button Styles
  static TextStyle get buttonText => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonText,
  );

  // Screen Title Styles
  static TextStyle get screenTitle => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get sectionTitle => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Error and Status Styles
  static TextStyle get errorMessage => TextStyle(
    fontSize: 14.sp,
    color: AppColors.error,
  );

  static TextStyle get successMessage => TextStyle(
    fontSize: 14.sp,
    color: AppColors.success,
  );

  // Profile Styles
  static TextStyle get profileName => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get profileBio => TextStyle(
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

  // Navigation Styles
  static TextStyle get navItem => TextStyle(
    fontSize: 12.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle get navItemSelected => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static final TextStyle appBarTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
} 