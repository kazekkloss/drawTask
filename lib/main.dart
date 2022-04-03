import 'package:drawtask/blocs/auth/auth_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/config.dart';
import 'repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authRepositoy = AuthRepository();
  runApp(Main(authRepository: authRepositoy));
}

class Main extends StatelessWidget {
  final AuthRepository _authRepository;

  const Main({
    Key? key,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository: _authRepository),
        child: const AuthRoot(),
      ),
    );
  }
}

class AuthRoot extends StatelessWidget {
  const AuthRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder(
        state: context.select((AuthBloc bloc) => bloc.state.status),
        onGeneratePages: authRootPages),
    );
  }
}
