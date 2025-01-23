import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/env_config.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment
  await EnvConfig.init();

  // Initialize service locator
  await setupServiceLocator();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              sl<AuthBloc>()..add(const CheckAuthStatusEvent()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => sl<SignUpBloc>(),
        ),
        BlocProvider<ForgotPasswordBloc>(
          create: (context) => sl<ForgotPasswordBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'AI Resume Builder',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        // themeMode: ThemeMode.system,
        themeMode: ThemeMode.light,
        routerConfig: goRouter,
        builder: (context, child) {
          // Update system UI overlay style based on theme
          // final isDark = Theme.of(context).brightness == Brightness.dark;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness
                  .dark, // isDark ? Brightness.light : Brightness.dark,
              statusBarBrightness: Brightness
                  .light, // isDark ? Brightness.dark : Brightness.light,
              systemNavigationBarColor:
                  AppTheme.lightTheme.scaffoldBackgroundColor,
              // isDark
              //     ? AppTheme.darkTheme.scaffoldBackgroundColor
              //     : AppTheme.lightTheme.scaffoldBackgroundColor,
              systemNavigationBarIconBrightness: Brightness.light,
              // isDark ? Brightness.light : Brightness.dark,
            ),
          );
          return child!;
        },
      ),
    );
  }
}
