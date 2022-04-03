import 'package:drawtask/cubits/login/login_cubit.dart';
import 'package:drawtask/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocProvider(
          create: (_) => LoginCubit(
            context.read<AuthRepository>(),
          ),
          child: const LoginForm(),
        ));
  }
}
