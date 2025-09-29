class RegisterResponse {
  final int status;
  final String message;

  bool get success => status == 0;

  RegisterResponse({required this.status, required this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(status: json["status"], message: json["message"]);
  }
}
