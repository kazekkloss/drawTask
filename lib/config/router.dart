import 'package:drawtask/screens/screens.dart';
import 'package:flutter/material.dart';

import '../blocs/auth/auth_bloc.dart';

List<Page> authRootPages(
  AuthStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthStatus.authenticated:
      return [HomeScreen.page()];
    case AuthStatus.unauthenticated:
      return [LoginScreen.page()];
    case AuthStatus.unconfirmed:
      return [VerificationScreen.page()];
  }
}
