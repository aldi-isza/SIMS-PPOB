import 'package:flutter/foundation.dart';
import 'package:sims_ppob/features/auth/data/auth_api.dart';
import 'package:sims_ppob/features/auth/data/models/login_request.dart';
import 'package:sims_ppob/features/auth/data/models/login_response.dart';
import 'package:sims_ppob/features/auth/data/models/register_request.dart';
import 'package:sims_ppob/features/auth/data/models/register_response.dart';

class AuthProvider extends ChangeNotifier {
  final AuthApi _api = AuthApi();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  RegisterResponse? _registerResponse;
  RegisterResponse? get registerResponse => _registerResponse;

  LoginResponse? _loginResponse;
  LoginResponse? get loginResponse => _loginResponse;

  Future<void> register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _registerResponse = null;
    notifyListeners();

    try {
      final request = RegisterRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
      );

      print("DEBUG Register Request: ${request.toJson()}");

      _registerResponse = await _api.register(request);

      print("DEBUG Register Response: ${_registerResponse?.message}");

      if (!_registerResponse!.success) {
        _errorMessage = _registerResponse!.message;
      }
    } catch (e) {
      _errorMessage = e.toString();
      print("Register Error: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    _loginResponse = null;
    notifyListeners();

    try {
      final request = LoginRequest(email: email, password: password);

      print("DEBUG Login Request: ${request.toJson()}");

      _loginResponse = await _api.login(request);

      print("DEBUG Login Response: ${_loginResponse?.message}");

      if (!_loginResponse!.success) {
        _errorMessage = _loginResponse!.message;
      }
    } catch (e) {
      _errorMessage = e.toString();
      print("Login Error: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
