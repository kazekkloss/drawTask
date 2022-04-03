import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore;
  final User user;

  UserRepository({FirebaseFirestore? firebaseFirestore, required this.user})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createUser({String? email, String? username}) {
    return _firebaseFirestore.collection('users').doc(user.id).set({
      'id': [user.id],
      'email': [email],
    });
  }
}
