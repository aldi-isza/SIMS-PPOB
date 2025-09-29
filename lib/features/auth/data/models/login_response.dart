class LoginResponse {
  final int status;
  final String message;
  final String? token;

  bool get success => status == 0;
  LoginResponse({required this.status, required this.message, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"],
      message: json["message"],
      token: json["data"]?["token"],
    );
  }
}
