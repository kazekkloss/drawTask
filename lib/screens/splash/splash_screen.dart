import 'dart:async';

import 'package:drawtask/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: ((context) => const SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: ((context, state) {
          // ignore: avoid_print
          print('Listener');
          if (state.status == AuthStatus.unauthenticated) {
            Timer(
                const Duration(seconds: 2),
                (() => Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, ModalRoute.withName('/login'))));
          }
          if (state.status == AuthStatus.unconfirmed) {
            Timer(
                const Duration(seconds: 2),
                (() => Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName,
                    ModalRoute.withName('/verification'))));
          }
          if (state.status == AuthStatus.authenticated) {
            Timer(
                const Duration(seconds: 2),
                (() => Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName, ModalRoute.withName('/home'))));
          }
        }),
        child: const Scaffold(
          body: Center(child: Text('Splash Screen')),
        ),
      ),
    );
  }
}
