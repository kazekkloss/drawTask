import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: VerificationScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Center(child: Text('confirm your email')),
            const SizedBox(height: 100),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogout());
                },
                child: const Text('Log out')),
          ],
        ),
      ),
    );
  }
}
