import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String? password;
  final DateTime? birthdate;
  final String? address;
  final String? profilePhoto;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.password,
    this.birthdate,
    this.address,
    this.profilePhoto,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      birthdate:
          map['birthdate'] != null ? DateTime.parse(map['birthdate']) : null,
      address: map['address'],
      profilePhoto: map['profile_photo'],
    );
  }

  factory UserModel.fromUser(User user, {String? password}) {
    return UserModel(
      id: user.id,
      username: user.email ?? 'No Name',
      email: user.email ?? '',
      password: password,
      birthdate: null,
      address: null,
      profilePhoto: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'birthdate': birthdate?.toIso8601String(),
      'address': address,
      'profile_photo': profilePhoto,
    };
  }
}
