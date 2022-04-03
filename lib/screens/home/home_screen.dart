import 'package:drawtask/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogout());
                },
                child: const Text('Log out')),
            const SizedBox(
              height: 40,
            ),
            Text(user.email.toString())
          ],
        ),
      ),
    );
  }
}
