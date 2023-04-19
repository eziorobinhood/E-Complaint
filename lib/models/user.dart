import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
      'confirmPassword': confirmPassword,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
