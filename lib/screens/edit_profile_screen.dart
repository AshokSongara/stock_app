import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/bloc/auth/auth_event.dart';
import 'dart:io' show Platform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/auth/auth_bloc.dart';
import '../models/user_model.dart';
import '../widgets/custom_text_form_field.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _bioFocusNode = FocusNode();
  final bool _isLoading = false;
  String? _errorMessage;
  final bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _bioFocusNode.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedUser = UserModel(
        id: widget.user.id,
        name: _nameController.text,
        email: widget.user.email,
        bio: _bioController.text,
      );
      context.read<AuthenticationBloc>().add(
            AuthenticationStatusChanged(
              AuthenticationStatus.authenticated,
              updatedUser,
            ),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildCupertinoUI() : _buildMaterialUI();
  }

  Widget _buildMaterialUI() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.editProfileTitle,
          style: TextStyle(fontSize: AppDimensions.fontSizeSubheading.sp),
        ),
        actions: [
          TextButton(
            onPressed: _handleSave,
            child: Text(
              AppStrings.saveButtonText,
              style: TextStyle(
                fontSize: AppDimensions.fontSizeBody.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.containerPaddingLarge.r),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildCupertinoUI() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          AppStrings.editProfileTitle,
          style: TextStyle(fontSize: AppDimensions.fontSizeSubheading.sp),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _handleSave,
          child: Text(
            AppStrings.saveButtonText,
            style: TextStyle(
              fontSize: AppDimensions.fontSizeBody.sp,
              color: AppColors.cupertinoPrimary,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.containerPaddingLarge.r),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Name field
          CustomTextFormField(
            controller: _nameController,
            focusNode: _nameFocusNode,
            labelText: AppStrings.nameLabel,
            prefixIcon: Platform.isIOS ? CupertinoIcons.person : Icons.person,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              _nameFocusNode.unfocus();
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.nameValidationEmpty;
              }
              return null;
            },
            enabled: !_isLoading,
          ),
          SizedBox(height: AppDimensions.spacingSmall.h),
          
          // Email field
          CustomTextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            labelText: AppStrings.emailLabel,
            prefixIcon: Platform.isIOS ? CupertinoIcons.mail : Icons.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              _emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(_bioFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.emailValidationEmpty;
              }
              if (!RegExp(AppStrings.emailRegexPattern).hasMatch(value)) {
                return AppStrings.emailValidationInvalid;
              }
              return null;
            },
            enabled: !_isLoading,
          ),
          SizedBox(height: AppDimensions.spacingSmall.h),
          
          // Bio field
          CustomTextFormField(
            controller: _bioController,
            focusNode: _bioFocusNode,
            labelText: AppStrings.bioLabel,
            prefixIcon: Platform.isIOS ? CupertinoIcons.text_quote : Icons.description,
            maxLines: 3,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              _bioFocusNode.unfocus();
              _handleSave();
            },
            validator: (value) {
              // Bio is optional, so no validation needed
              return null;
            },
            enabled: !_isLoading,
          ),
          SizedBox(height: AppDimensions.spacingMedium.h),
          
          // Loading indicator
          if (_isLoading)
            Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator()
                  : const CircularProgressIndicator(),
            ),
          
          // Success message
          if (_isSuccess)
            Container(
              padding: EdgeInsets.all(AppDimensions.containerPaddingSmall.r),
              decoration: BoxDecoration(
                color: (Platform.isIOS ? CupertinoColors.systemGreen : AppColors.success).withAlpha(26),
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Platform.isIOS ? CupertinoIcons.checkmark_circle : Icons.check_circle,
                    color: Platform.isIOS ? CupertinoColors.systemGreen : AppColors.success,
                  ),
                  SizedBox(width: AppDimensions.spacingSmall.w),
                  Text(
                    AppStrings.profileUpdateSuccess,
                    style: TextStyle(
                      color: Platform.isIOS ? CupertinoColors.systemGreen : AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          
          // Error message
          if (_errorMessage != null)
            Container(
              padding: EdgeInsets.all(AppDimensions.containerPaddingSmall.r),
              decoration: BoxDecoration(
                color: (Platform.isIOS ? CupertinoColors.systemRed : AppColors.error).withAlpha(26),
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Platform.isIOS ? CupertinoIcons.exclamationmark_triangle : Icons.error,
                    color: Platform.isIOS ? CupertinoColors.systemRed : AppColors.error,
                  ),
                  SizedBox(width: AppDimensions.spacingSmall.w),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Platform.isIOS ? CupertinoColors.systemRed : AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}