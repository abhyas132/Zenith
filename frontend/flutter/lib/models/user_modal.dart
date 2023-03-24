// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String userId;
  final String name;
  final String email;
  final String password;
  int zenCoins;

  User({
    this.userId = '',
    required this.name,
    required this.email,
    required this.password,
    this.zenCoins = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      'zenCoins': zenCoins,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      zenCoins: map['zenCoins'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? userId,
    String? name,
    String? email,
    String? password,
    int? zenCoins,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      zenCoins: zenCoins ?? this.zenCoins,
    );
  }
}
