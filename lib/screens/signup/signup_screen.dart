import 'package:drawtask/cubits/signup/signup_cubit.dart';
import 'package:drawtask/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: BlocProvider<SignupCubit>(
        create: (_) => SignupCubit(context.read<AuthRepository>()),
        child: const SignupForm(),
      ),
    );
  }
}
