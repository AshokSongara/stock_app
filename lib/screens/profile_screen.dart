import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/bloc/auth/auth_event.dart';
import 'package:flutter_assignment/bloc/auth/auth_state.dart';
import 'dart:io' show Platform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/auth/auth_bloc.dart';
import '../models/user_model.dart';
import '../constants/app_strings.dart';
import '../constants/app_dimensions.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return _buildProfileScreen(context, state.user);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildProfileScreen(BuildContext context, UserModel user) {
    return Platform.isIOS ? _buildCupertinoUI(context, user) : _buildMaterialUI(context, user);
  }

  Widget _buildCupertinoUI(BuildContext context, UserModel user) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          AppStrings.profileTitle,
          style: TextStyle(fontSize: AppDimensions.fontSizeSubheading.sp),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.pencil),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => EditProfileScreen(user: user),
                  ),
                );
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.square_arrow_right),
              onPressed: () => _handleLogout(context),
            ),
          ],
        ),
      ),
      child: SafeArea(child: _buildProfileContent(context, user)),
    );
  }

  Widget _buildMaterialUI(BuildContext context, UserModel user) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.profileTitle,
          style: TextStyle(fontSize: AppDimensions.fontSizeSubheading.sp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(user: user),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _handleLogout(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: _buildProfileContent(context, user),
    );
  }

  Widget _buildProfileContent(BuildContext context, UserModel user) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.containerPaddingMedium.w,
        vertical: AppDimensions.containerPaddingSmall.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppDimensions.spacingSmall.h),
          SizedBox(height: AppDimensions.spacingSmall.h),
          _buildInfoCard(
            title: AppStrings.nameLabel,
            content: user.name,
            icon: Platform.isIOS ? CupertinoIcons.person : Icons.person,
          ),
          SizedBox(height: AppDimensions.spacingSmall.h),
          _buildInfoCard(
            title: AppStrings.emailLabel,
            content: user.email,
            icon: Platform.isIOS ? CupertinoIcons.mail : Icons.email,
          ),
          if (user.bio.isNotEmpty) ...[
            SizedBox(height: AppDimensions.spacingSmall.h),
            _buildInfoCard(
              title: AppStrings.bioLabel,
              content: user.bio,
              icon: Platform.isIOS ? CupertinoIcons.info : Icons.info,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Platform.isIOS ? CupertinoColors.systemGrey6 : Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall.r),
        border: Border.all(
          color: Platform.isIOS ? CupertinoColors.systemGrey4 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.containerPaddingSmall.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: AppDimensions.iconSizeSmall.r,
                  color: Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey.shade600,
                ),
                SizedBox(width: AppDimensions.spacingSmall.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppDimensions.fontSizeSmall.sp,
                    fontWeight: FontWeight.w500,
                    color: Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spacingTiny.h),
            Text(
              content,
              style: TextStyle(
                fontSize: AppDimensions.fontSizeBody.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
  }
}