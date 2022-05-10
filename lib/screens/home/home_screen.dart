import 'package:drawtask/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 160),
          const Text('Home'),
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
