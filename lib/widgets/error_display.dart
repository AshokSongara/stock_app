import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorDisplay({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacingMedium.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Platform.isIOS ? CupertinoIcons.exclamationmark_circle : Icons.error_outline,
              size: 48.r,
              color: AppColors.error,
            ),
            SizedBox(height: AppDimensions.spacingMedium.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimensions.fontSizeBody.sp,
                color: AppColors.textPrimary,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: AppDimensions.spacingMedium.h),
              Platform.isIOS
                  ? CupertinoButton(
                      onPressed: onRetry,
                      child: const Text('Retry'),
                    )
                  : ElevatedButton(
                      onPressed: onRetry,
                      child: const Text('Retry'),
                    ),
            ],
          ],
        ),
      ),
    );
  }
}