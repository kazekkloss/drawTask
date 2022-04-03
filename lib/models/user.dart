import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;

  const User({required this.id, this.email});

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
      id: snap['id'],
      email: snap['email'],
    );
    return user;
  }

  @override
  List<Object?> get props => [id, email];
}
