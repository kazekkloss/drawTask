import 'package:drawtask/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  static const String routeName = '/verification';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const VerificationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 160),
          const Text('Verification'),
          const SizedBox(height: 60),
          ElevatedButton(
              onPressed: () async {
                await RepositoryProvider.of<AuthRepository>(context).signOut();
                await Navigator.pushNamed(context, '/authRoot');
              },
              child: const Text('signout'))
        ],
      )),
    );
  }
}