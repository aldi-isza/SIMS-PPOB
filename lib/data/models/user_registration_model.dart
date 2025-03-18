import 'dart:convert';

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

  // Factory constructor untuk parsing dari JSON
  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      password: json["password"],
    );
  }

  // Method untuk konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
    };
  }

  // Method untuk mengupdate instance tanpa membuat ulang dari awal
  UserRegistration copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
  }) {
    return UserRegistration(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
    );
  }
}

// Fungsi helper untuk konversi JSON ke model
UserRegistration userRegistrationFromJson(String str) =>
    UserRegistration.fromJson(json.decode(str));

// Fungsi helper untuk konversi model ke JSON
String userRegistrationToJson(UserRegistration data) =>
    json.encode(data.toJson());
