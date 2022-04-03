import 'package:drawtask/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/signup/signup_cubit.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.error) {}
      },
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _EmailInput(),
              SizedBox(height: 30),
              _PasswordInput(),
              SizedBox(
                height: 40,
              ),
              _SignupButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: ((previous, current) => previous.email != current.email),
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: ((previous, current) => previous.password != current.password),
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<SignupCubit>().paswordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: ((previous, current) => previous.status != current.status),
      builder: (context, state) {
        return state.status == SignupStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  try {
                    context.read<SignupCubit>().signupCubit();
                  } catch (_) {}
                },
                child: const Text('Ok'));
      },
    );
  }
}
