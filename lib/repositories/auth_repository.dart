import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawtask/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class SignUpFail implements Exception {
  final String message;
  const SignUpFail([
    this.message = 'unexpected error',
  ]);

  //change text error
  factory SignUpFail.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpFail(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpFail(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpFail(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpFail(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpFail(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpFail();
    }
  }
}

class LogInFail implements Exception {
  final String message;
  const LogInFail([
    this.message = 'unexpected error',
  ]);

  //change text error
  factory LogInFail.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInFail(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInFail(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInFail(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInFail(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInFail();
    }
  }
}

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository(
      {FirebaseFirestore? firebaseFirestore, auth.FirebaseAuth? firebaseAuth})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  //STREAM USER
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  //SIGNUP
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firebaseAuth.currentUser!.sendEmailVerification();
      final user = credential.user;
      _firebaseFirestore.collection(CollectionPath.users).doc(user?.uid).set({
        "email": email,
      });
      return user;
    } catch (_) {
      throw const SignUpFail();
    }
  }

  //CHECK VERIFICATION EMAIL
  bool get verify {
    bool status = false;
    var _user = _firebaseAuth.currentUser;
    try {
      if (_user != null) {
        status = _user.emailVerified;
        if (status == false) {
          print('not verificated');
        }
      }
    } catch (_) {}
    return status;
  }

  //LOGIN
  Future<auth.User?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      return user;
    } catch (_) {
      throw const LogInFail();
    }
  }

  //LOGOUT
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
