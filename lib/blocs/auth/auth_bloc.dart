import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AuthState.authenticated(authRepository.currentUser)
            : const AuthState.unauthenticated()) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogout>(_onLogout);

    _userSubscription =
        _authRepository.user.listen((user) => add(AuthUserChanged(user)));
  }

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user.isNotEmpty) {
      _authRepository.verify
          ? emit(AuthState.authenticated(event.user))
          : emit(const AuthState.unconfirmed());
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) {
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
