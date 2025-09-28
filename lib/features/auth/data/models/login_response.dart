class LoginResponse {
  final int status;
  final String email;
  final String? token;

  bool get success => status == 0;
  LoginResponse({required this.status, required this.email, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"],
      email: json["email"],
      token: json["data"]?["token"],
    );
  }
}
