import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sims_ppob/features/auth/data/models/login_request.dart';
import 'package:sims_ppob/features/auth/data/models/login_response.dart';
import 'package:sims_ppob/features/auth/data/models/register_request.dart';
import 'package:sims_ppob/features/auth/data/models/register_response.dart';

class AuthApi {
  // 1.  baseUrl
  static const String baseUrl =
      "https://take-home-test-api.nutech-integrasi.com";

  // 2. API SERVICE Register
  Future<RegisterResponse> register(RegisterRequest request) async {
    final url = Uri.parse("$baseUrl/registration");
    final response = await http.post(
      url,
      headers: {"accept": "aplication/json", "Content-Type": "aplication/json"},
      body: jsonEncode(request.toJson()),
    );
    return RegisterResponse.fromJson(json.decode(response.body));
  }

  // 3. API SERVICE Login
  Future<LoginResponse> login(LoginRequest request) async {
    final url = Uri.parse("$baseUrl/login");
    final response = await http.post(
      url,
      headers: {"accept": "aplication/json", "Content-Type": "aplication/json"},
      body: json.encode(request.toJson()),
    );
    return LoginResponse.fromJson(json.decode(response.body));
  }
}
