import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/bloc/auth/auth_event.dart';
import 'package:flutter_assignment/bloc/auth/auth_state.dart';
import 'dart:io' show Platform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_assignment/bloc/auth/auth_bloc.dart';
import 'package:flutter_assignment/screens/login_screen.dart';
import 'package:flutter_assignment/screens/stock_screen.dart';
import 'package:flutter_assignment/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Check authentication status after animation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.read<AuthenticationBloc>().add(AuthenticationCheckRequested());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          _navigateToScreen(const StockScreen());
        } else if (state is AuthenticationFailure) {
          _navigateToScreen(const LoginScreen());
        }
      },
      child: Container(
        color: AppColors.info,
        child: Scaffold(
          backgroundColor: AppColors.info,
          body: SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo with platform-specific icon
                          Icon(
                            Platform.isIOS ? CupertinoIcons.chart_bar_fill : Icons.show_chart,
                            size: 80.r,
                            color: Platform.isIOS ? AppColors.cupertinoPrimary : AppColors.primary,
                          ),
                          SizedBox(height: 24.h),
                          // App name with animation
                          Text(
                            'Stock Market',
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          // Tagline
                          Text(
                            'Track your investments',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textSecondary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 48.h),
                          // Loading indicator
                          SizedBox(
                            width: 40.w,
                            height: 40.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.w,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Platform.isIOS ? AppColors.cupertinoPrimary : AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(Widget screen) {
    Navigator.of(context).pushReplacement(
      Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => screen)
          : MaterialPageRoute(builder: (context) => screen),
    );
  }
} 