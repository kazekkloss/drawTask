import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/signup/signup_cubit.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
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
                      context.read<SignupCubit>().emailChanged(value);
                    }),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    context.read<SignupCubit>().passwordChanged(value);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      await context.read<SignupCubit>().signUpCubit();
                      await Navigator.pushNamed(context, '/authRoot');
                    },
                    child: const Text('sign in')),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('log in to yoour account')),
              ],
            ),
          ),
        );
      },
    );
  }
}
