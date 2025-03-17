// To parse this JSON data, do
//
//     final userRegistration = userRegistrationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserRegistration userRegistrationFromJson(String str) =>
    UserRegistration.fromJson(json.decode(str));

String userRegistrationToJson(UserRegistration data) =>
    json.encode(data.toJson());

class UserRegistration {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  UserRegistration({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) =>
      UserRegistration(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "password": password,
  };
}
