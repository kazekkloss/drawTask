part of 'auth_bloc.dart';

enum AuthStatus { unknown, unauthenticated, unconfirmed, authenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final auth.User? user;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  const AuthState.unknown() : this._();

  const AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  const AuthState.unconfirmed()
      : this._(
          status: AuthStatus.unconfirmed,
        );

  const AuthState.authenticated({required auth.User user})
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  @override
  List<Object?> get props => [status, user];
}
