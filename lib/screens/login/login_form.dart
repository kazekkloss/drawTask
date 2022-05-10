import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/login/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    onChanged: (value) {
                      context.read<LoginCubit>().emailChanged(value);
                    }),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    context.read<LoginCubit>().passwordChanged(value);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      await context.read<LoginCubit>().logInCubit();
                      await Navigator.pushNamed(context, '/authRoot');
                    },
                    child: const Text('log in')),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('create account')),
              ],
            ),
          ),
        );
      },
    );
  }
}
