import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/auth/auth_event.dart';
import 'package:flutter_assignment/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_assignment/bloc/auth/auth_bloc.dart';
import 'package:flutter_assignment/bloc/stock/stock_bloc.dart';
import 'package:flutter_assignment/services/auth_repository.dart';
import 'package:flutter_assignment/services/session_repository.dart';
import 'package:flutter_assignment/services/mock_stock_api.dart';
import 'package:flutter_assignment/constants/app_theme.dart';

import 'constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sessionRepository = SessionRepository();
  await sessionRepository.init();
  runApp(MyApp(sessionRepository: sessionRepository));
}

class MyApp extends StatelessWidget {
  final SessionRepository sessionRepository;

  const MyApp({super.key, required this.sessionRepository});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value: sessionRepository,
            ),
            RepositoryProvider(
              create: (context) => AuthenticationRepository(
                sessionRepository: sessionRepository,
              ),
            ),
            RepositoryProvider<StockApi>(
              create: (context) => StockApi(),
            ),
          ],
          child: Builder(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AuthenticationBloc(
                    authRepository: context.read<AuthenticationRepository>(),
                    sessionRepository: context.read<SessionRepository>(),
                  )..add(AuthenticationCheckRequested()),
                ),
                BlocProvider(
                  create: (context) => StockBloc(
                    authRepository: context.read<AuthenticationRepository>(),
                    stockApi: context.read<StockApi>(),
                  ),
                ),
              ],
              child: ScaffoldMessenger(
                child: Platform.isIOS
                    ? CupertinoApp(
                        title: AppStrings.appTitle,
                        theme: AppTheme.cupertinoTheme(),
                        debugShowCheckedModeBanner: false,
                        home: const SplashScreen(),
                      )
                    : MaterialApp(
                        title: AppStrings.appTitle,
                        theme: AppTheme.materialTheme(),
                        debugShowCheckedModeBanner: false,
                        home: const SplashScreen(),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
