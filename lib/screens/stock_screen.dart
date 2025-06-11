import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/bloc/auth/auth_event.dart';
import 'package:flutter_assignment/bloc/stock/stock_event.dart';
import 'package:flutter_assignment/bloc/stock/stock_state.dart';
import 'dart:io' show Platform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/stock/stock_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/stock_index_header.dart';
import '../widgets/stock_list_item.dart';
import '../widgets/error_display.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import '../services/mock_stock_api.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockBloc(
        authRepository: context.read<AuthenticationBloc>().authRepository,
        stockApi: StockApi(),
      )..add(StockLoadRequested()),
      child: const StockScreenContent(),
    );
  }
}

class StockScreenContent extends StatelessWidget {
  const StockScreenContent({super.key});

  void _handleProfile(BuildContext context) {
    if (Platform.isIOS) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    } else {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  void _performLogout(BuildContext context) {
    // Dispatch logout event
    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());

    // Navigate to login screen with animation
    if (Platform.isIOS) {
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildCupertinoUI(context) : _buildMaterialUI(context);
  }

  Widget _buildMaterialUI(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Stocks',
          style: AppTextStyles.appBarTitle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
            onPressed: () => {
              _handleProfile(context)
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textPrimary),
            onPressed: () => {
              _performLogout(context)
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildCupertinoUI(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.background,
        middle: Text(
          'Stocks',
          style: AppTextStyles.appBarTitle,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.person, color: AppColors.textPrimary),
              onPressed: () => {
                _handleProfile(context)
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.square_arrow_right, color: AppColors.textPrimary),
              onPressed: () => {
                _performLogout(context)
              },
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, StockState state) {
    if (state is StockLoadInProgress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is StockLoadFailure) {
      return ErrorDisplay(
        message: state.error,
        onRetry: () {
          context.read<StockBloc>().add(StockLoadRequested());
        },
      );
    }

    if (state is StockLoadSuccess) {
      return CustomScrollView(
        slivers: [
          // Header with indices in horizontal ListView
          SliverToBoxAdapter(
            child: Container(
              height: 110,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.indices.length,
                itemBuilder: (context, index) {
                  final stock = state.indices[index];
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: StockIndexHeader(stock: stock),
                    ),
                  );
                },
              ),
            ),
          ),
          // Stock list
          SliverPadding(
            padding: const EdgeInsets.only(top: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final stock = state.stocks[index];
                  return StockListItem(stock: stock);
                },
                childCount: state.stocks.length,
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
