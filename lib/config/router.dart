import 'package:drawtask/blocs/auth/auth_bloc.dart';
import 'package:drawtask/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static const String routeName = '/authRoot';

  static Route _authRoute() {
    return MaterialPageRoute(
      builder: (context) {
        print(BlocProvider.of<AuthBloc>(context).state.status);
        var status = BlocProvider.of<AuthBloc>(context).state.status;
        switch (status) {
          case AuthStatus.unauthenticated:
            return const LoginScreen();
          case AuthStatus.unconfirmed:
            return const VerificationScreen();
          case AuthStatus.authenticated:
            return const HomeScreen();
          default:
            return const Scaffold(
              body: Center(
                child: Text('Error auth route'),
              ),
            );
        }
      },
    );
  }

  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print('Route is: ${settings.name}');

    switch (settings.name) {
      case AppRouter.routeName:
        return _authRoute();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case VerificationScreen.routeName:
        return VerificationScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(
                child: Text('ERROR ROUTE'),
              ),
            ),
        settings: const RouteSettings(name: '/error'));
  }
}
