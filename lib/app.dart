import 'package:drawtask/blocs/blocs.dart';
import 'package:drawtask/config/router.dart';
import 'package:drawtask/cubits/login/login_cubit.dart';
import 'package:drawtask/cubits/signup/signup_cubit.dart';
import 'package:drawtask/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/repositories.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) =>
                AuthBloc(authRepository: context.read<AuthRepository>())),
          ),
          BlocProvider(
              create: ((context) =>
                  SignupCubit(authRepository: context.read<AuthRepository>()))),
          BlocProvider(
            create: (context) =>
                LoginCubit(authRepository: context.read<AuthRepository>()),
          ),
        ],
        child: const MaterialApp(
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
