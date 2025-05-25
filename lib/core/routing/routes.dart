import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osp/core/networking/di/dependency_injection.dart';
import 'package:osp/core/routing/routes_name.dart';
import 'package:osp/features/auth/cubit/auth_cubit.dart';
import 'package:osp/features/auth/login_screen.dart';
import 'package:osp/features/auth/register.dart';
import 'package:osp/features/auth/reset_password.dart';
import 'package:osp/features/home/home_screen.dart';
import 'package:osp/features/settings/settings.dart';
import 'package:osp/main.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: HomeScreen(),
          ),
        );

      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: LoginScreen(),
          ),
        );

      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: RegisterScreen(),
          ),
        );

      case RoutesName.resetPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => ResetPasswordScreen());

      case RoutesName.settings:
        return MaterialPageRoute(
            builder: (BuildContext context) => SettingsScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
