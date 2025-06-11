import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/bloc/auth/auth_event.dart';
import 'package:flutter_assignment/bloc/auth/auth_state.dart';
import 'dart:io' show Platform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/custom_text_form_field.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'stock_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          Navigator.of(context).pushReplacement(
            Platform.isIOS
                ? CupertinoPageRoute(builder: (context) => const StockScreen())
                : MaterialPageRoute(builder: (context) => const StockScreen()),
          );
        } else if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Platform.isIOS ? _buildCupertinoUI() : _buildMaterialUI(),
    );
  }

  Widget _buildMaterialUI() {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.containerPaddingLarge.r),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: AppDimensions.iconSizeLarge.r,
                            color: AppColors.primary,
                          ),
                          SizedBox(height: AppDimensions.spacingSmall.h),
                          Text(
                            AppStrings.loginTitle,
                            style: TextStyle(
                              fontSize: AppDimensions.fontSizeHeading.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: AppDimensions.spacingExtraLarge.h),
                          
                          // Email field
                          CustomTextFormField(
                            controller: _emailController,
                            labelText: AppStrings.emailLabel,
                            hintText: AppStrings.emailHint,
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            enabled: state is! AuthenticationLoading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emailValidationEmpty;
                              }
                              if (!RegExp(AppStrings.emailRegexPattern).hasMatch(value)) {
                                return AppStrings.emailValidationInvalid;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppDimensions.spacingSmall.h),
                          
                          // Password field
                          CustomTextFormField(
                            controller: _passwordController,
                            labelText: AppStrings.passwordLabel,
                            hintText: AppStrings.passwordHint,
                            prefixIcon: Icons.lock,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            enabled: state is! AuthenticationLoading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.passwordValidationEmpty;
                              }
                              if (value.length < 6) {
                                return AppStrings.passwordValidationLength;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppDimensions.spacingMedium.h),
                          
                          // Error message display
                          if (_errorMessage != null)
                            Container(
                              padding: EdgeInsets.all(AppDimensions.containerPaddingSmall.r),
                              decoration: BoxDecoration(
                                color: AppColors.error.withAlpha(26),
                                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.error, color: AppColors.error, size: AppDimensions.iconSizeSmall.r),
                                  SizedBox(width: AppDimensions.spacingExtraLarge.w),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: TextStyle(color: AppColors.error, fontSize: AppDimensions.fontSizeBody.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_errorMessage != null) SizedBox(height: AppDimensions.spacingSmall.h),
                          
                          // Login button
                          SizedBox(
                            height: AppDimensions.buttonHeight.h,
                            child: ElevatedButton(
                              onPressed: state is AuthenticationLoading
                                  ? null
                                  : () => _handleLogin(),
                              child: state is AuthenticationLoading
                                  ? SizedBox(
                                      height: AppDimensions.spacingMedium.h,
                                      width: AppDimensions.spacingMedium.w,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.buttonText,
                                      ),
                                    )
                                  : Text(
                                      AppStrings.loginButtonText,
                                      style: TextStyle(fontSize: AppDimensions.fontSizeBody.sp),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (state is AuthenticationLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCupertinoUI() {
    return CupertinoPageScaffold(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.containerPaddingLarge.r),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            CupertinoIcons.chart_bar_fill,
                            size: AppDimensions.iconSizeLarge.r,
                            color: AppColors.cupertinoPrimary,
                          ),
                          SizedBox(height: AppDimensions.spacingSmall.h),
                          Text(
                            AppStrings.loginTitle,
                            style: TextStyle(
                              fontSize: AppDimensions.fontSizeHeading.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: AppDimensions.spacingExtraLarge.h),
                          
                          // Email field
                          CustomTextFormField(
                            controller: _emailController,
                            labelText: AppStrings.emailLabel,
                            hintText: AppStrings.emailHint,
                            prefixIcon: CupertinoIcons.mail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            enabled: state is! AuthenticationLoading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emailValidationEmpty;
                              }
                              if (!RegExp(AppStrings.emailRegexPattern).hasMatch(value)) {
                                return AppStrings.emailValidationInvalid;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppDimensions.spacingSmall.h),
                          
                          // Password field
                          CustomTextFormField(
                            controller: _passwordController,
                            labelText: AppStrings.passwordLabel,
                            hintText: AppStrings.passwordHint,
                            prefixIcon: CupertinoIcons.lock,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            enabled: state is! AuthenticationLoading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.passwordValidationEmpty;
                              }
                              if (value.length < 6) {
                                return AppStrings.passwordValidationLength;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppDimensions.spacingMedium.h),
                          
                          // Error message display
                          if (_errorMessage != null)
                            Container(
                              padding: EdgeInsets.all(AppDimensions.containerPaddingSmall.r),
                              decoration: BoxDecoration(
                                color: AppColors.cupertinoError.withAlpha(51),
                                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.exclamationmark_triangle, color: AppColors.cupertinoError, size: AppDimensions.iconSizeSmall.r),
                                  SizedBox(width: AppDimensions.spacingExtraLarge.w),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: TextStyle(color: AppColors.cupertinoError, fontSize: AppDimensions.fontSizeBody.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_errorMessage != null) SizedBox(height: AppDimensions.spacingSmall.h),
                          
                          // Login button
                          SizedBox(
                            height: AppDimensions.buttonHeight.h,
                            child: state is AuthenticationLoading
                                ? const CupertinoActivityIndicator()
                                : CupertinoButton.filled(
                                    onPressed: () => _handleLogin(),
                                    child: Text(AppStrings.loginButtonText, style: TextStyle(fontSize: AppDimensions.fontSizeBody.sp)),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (state is AuthenticationLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
  
  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthenticationBloc>().add(
            AuthenticationLoginRequested(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }
}